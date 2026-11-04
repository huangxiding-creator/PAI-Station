.class public final Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;
.super Landroid/app/Service;
.source "InspectBoll.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$Companion;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nInspectBoll.kt\nKotlin\n*S Kotlin\n*F\n+ 1 InspectBoll.kt\ncom/rokid/security/phone/sdk/server/inspection/InspectBoll\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,218:1\n1#2:219\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000B\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0008\n\u0002\u0008\n\u0018\u0000 \u001f2\u00020\u0001:\u0001\u001fB\u0005\u00a2\u0006\u0002\u0010\u0002J\u0008\u0010\r\u001a\u00020\u000eH\u0002J\u0014\u0010\u000f\u001a\u0004\u0018\u00010\u00102\u0008\u0010\u0011\u001a\u0004\u0018\u00010\u0012H\u0016J\u0008\u0010\u0013\u001a\u00020\u000eH\u0016J\u0008\u0010\u0014\u001a\u00020\u000eH\u0016J\"\u0010\u0015\u001a\u00020\u00162\u0008\u0010\u0011\u001a\u0004\u0018\u00010\u00122\u0006\u0010\u0017\u001a\u00020\u00162\u0006\u0010\u0018\u001a\u00020\u0016H\u0016J\u0010\u0010\u0019\u001a\u00020\u000e2\u0006\u0010\u001a\u001a\u00020\u0004H\u0002J\u0010\u0010\u001b\u001a\u00020\u000e2\u0006\u0010\u001c\u001a\u00020\u0004H\u0002J\u0010\u0010\u001d\u001a\u00020\u000e2\u0006\u0010\u001e\u001a\u00020\u0004H\u0002R\u0014\u0010\u0003\u001a\u00020\u0004X\u0086D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006R\u0010\u0010\u0007\u001a\u0004\u0018\u00010\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\t\u001a\u0004\u0018\u00010\nX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\u000cX\u0082.\u00a2\u0006\u0002\n\u0000\u00a8\u0006 "
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;",
        "Landroid/app/Service;",
        "()V",
        "TAG",
        "",
        "getTAG",
        "()Ljava/lang/String;",
        "floatingView",
        "Landroid/view/View;",
        "params",
        "Landroid/view/WindowManager$LayoutParams;",
        "windowManager",
        "Landroid/view/WindowManager;",
        "hideFloatingBall",
        "",
        "onBind",
        "Landroid/os/IBinder;",
        "intent",
        "Landroid/content/Intent;",
        "onCreate",
        "onDestroy",
        "onStartCommand",
        "",
        "flags",
        "startId",
        "showFloatingBall",
        "initialStatus",
        "updateStatus",
        "newStatus",
        "updateVisualStyle",
        "status",
        "Companion",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final ACTION_HIDE:Ljava/lang/String; = "com.example.floatingball.ACTION_HIDE"

.field public static final ACTION_SHOW:Ljava/lang/String; = "com.example.floatingball.ACTION_SHOW"

.field public static final ACTION_UPDATE_STATUS:Ljava/lang/String; = "com.example.floatingball.ACTION_UPDATE_STATUS"

.field public static final Companion:Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$Companion;

.field public static final EXTRA_STATUS:Ljava/lang/String; = "extra_status"

.field public static final STATUS_IDLE:Ljava/lang/String; = "\u7a7a\u95f2"

.field public static final STATUS_INSPECTING:Ljava/lang/String; = "\u5de1\u68c0\u4e2d"

.field public static final STATUS_UPLOADING:Ljava/lang/String; = "\u6570\u636e\u4e0a\u4f20\u4e2d"


# instance fields
.field private final TAG:Ljava/lang/String;

.field private floatingView:Landroid/view/View;

.field private params:Landroid/view/WindowManager$LayoutParams;

.field private windowManager:Landroid/view/WindowManager;


# direct methods
.method public static synthetic $r8$lambda$H1UpDFatLS13miQQydvYRz0qn2Q(Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->showFloatingBall$lambda$2(Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$XNyYxTlALoU-SEEEKIvxh4y6Qfs(Landroid/graphics/drawable/Drawable;Landroid/animation/ValueAnimator;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->updateVisualStyle$lambda$5(Landroid/graphics/drawable/Drawable;Landroid/animation/ValueAnimator;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->Companion:Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$Companion;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 23
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 37
    const-string v0, "InspectBoll"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->TAG:Ljava/lang/String;

    .line 23
    return-void
.end method

.method public static final synthetic access$getFloatingView$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;)Landroid/view/View;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;

    .line 23
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->floatingView:Landroid/view/View;

    return-object v0
.end method

.method public static final synthetic access$getParams$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;)Landroid/view/WindowManager$LayoutParams;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;

    .line 23
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->params:Landroid/view/WindowManager$LayoutParams;

    return-object v0
.end method

.method public static final synthetic access$getWindowManager$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;)Landroid/view/WindowManager;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;

    .line 23
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->windowManager:Landroid/view/WindowManager;

    return-object v0
.end method

.method private final hideFloatingBall()V
    .locals 4

    .line 153
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->floatingView:Landroid/view/View;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    .local v0, "it":Landroid/view/View;
    const/4 v2, 0x0

    .line 154
    .local v2, "$i$a$-let-InspectBoll$hideFloatingBall$1":I
    nop

    .line 155
    :try_start_0
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->windowManager:Landroid/view/WindowManager;

    if-nez v3, :cond_0

    const-string/jumbo v3, "windowManager"

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v3, v1

    :cond_0
    invoke-interface {v3, v0}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 156
    :catch_0
    move-exception v3

    .line 157
    .local v3, "e":Ljava/lang/Exception;
    invoke-virtual {v3}, Ljava/lang/Exception;->printStackTrace()V

    .line 159
    .end local v3    # "e":Ljava/lang/Exception;
    :goto_0
    nop

    .line 153
    .end local v0    # "it":Landroid/view/View;
    .end local v2    # "$i$a$-let-InspectBoll$hideFloatingBall$1":I
    nop

    .line 160
    :cond_1
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->floatingView:Landroid/view/View;

    .line 161
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->params:Landroid/view/WindowManager$LayoutParams;

    .line 162
    return-void
.end method

.method private final showFloatingBall(Ljava/lang/String;)V
    .locals 9
    .param p1, "initialStatus"    # Ljava/lang/String;

    .line 84
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->floatingView:Landroid/view/View;

    if-eqz v0, :cond_0

    return-void

    .line 86
    :cond_0
    const-string v0, "layout_inflater"

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    const-string v1, "null cannot be cast to non-null type android.view.LayoutInflater"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Landroid/view/LayoutInflater;

    .line 87
    .local v0, "inflater":Landroid/view/LayoutInflater;
    sget v1, Lcom/rokid/security/phone/sdk/server/R$layout;->inspect_boll:I

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->floatingView:Landroid/view/View;

    .line 89
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1a

    if-lt v1, v3, :cond_1

    .line 90
    const/16 v1, 0x7f6

    move v6, v1

    goto :goto_0

    .line 92
    :cond_1
    const/16 v1, 0x7d2

    move v6, v1

    .line 89
    :goto_0
    nop

    .line 94
    .local v6, "type":I
    new-instance v1, Landroid/view/WindowManager$LayoutParams;

    .line 95
    nop

    .line 96
    nop

    .line 97
    nop

    .line 98
    nop

    .line 99
    nop

    .line 94
    const/4 v4, -0x2

    const/4 v5, -0x2

    const/16 v7, 0x8

    const/4 v8, -0x3

    move-object v3, v1

    invoke-direct/range {v3 .. v8}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V

    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->params:Landroid/view/WindowManager$LayoutParams;

    .line 102
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->params:Landroid/view/WindowManager$LayoutParams;

    if-nez v1, :cond_2

    goto :goto_1

    :cond_2
    const v3, 0x800033

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 103
    :goto_1
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->params:Landroid/view/WindowManager$LayoutParams;

    if-nez v1, :cond_3

    goto :goto_2

    :cond_3
    const/16 v3, 0x32

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 104
    :goto_2
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->params:Landroid/view/WindowManager$LayoutParams;

    if-nez v1, :cond_4

    goto :goto_3

    :cond_4
    const/16 v3, 0xc8

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 106
    :goto_3
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->floatingView:Landroid/view/View;

    if-eqz v1, :cond_5

    new-instance v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;

    invoke-direct {v3, p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;)V

    check-cast v3, Landroid/view/View$OnTouchListener;

    invoke-virtual {v1, v3}, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 134
    :cond_5
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->floatingView:Landroid/view/View;

    if-eqz v1, :cond_6

    new-instance v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$$ExternalSyntheticLambda0;

    invoke-direct {v3, p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;)V

    invoke-virtual {v1, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 146
    :cond_6
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->floatingView:Landroid/view/View;

    if-eqz v1, :cond_7

    sget v3, Lcom/rokid/security/phone/sdk/server/R$id;->tv_status:I

    invoke-virtual {v1, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    goto :goto_4

    :cond_7
    move-object v1, v2

    :goto_4
    if-nez v1, :cond_8

    goto :goto_5

    :cond_8
    move-object v3, p1

    check-cast v3, Ljava/lang/CharSequence;

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 147
    :goto_5
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->updateVisualStyle(Ljava/lang/String;)V

    .line 149
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->params:Landroid/view/WindowManager$LayoutParams;

    if-eqz v1, :cond_a

    .line 219
    .local v1, "it":Landroid/view/WindowManager$LayoutParams;
    const/4 v3, 0x0

    .line 149
    .local v3, "$i$a$-let-InspectBoll$showFloatingBall$3":I
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->windowManager:Landroid/view/WindowManager;

    if-nez v4, :cond_9

    const-string/jumbo v4, "windowManager"

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_6

    :cond_9
    move-object v2, v4

    :goto_6
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->floatingView:Landroid/view/View;

    move-object v5, v1

    check-cast v5, Landroid/view/ViewGroup$LayoutParams;

    invoke-interface {v2, v4, v5}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 150
    .end local v1    # "it":Landroid/view/WindowManager$LayoutParams;
    .end local v3    # "$i$a$-let-InspectBoll$showFloatingBall$3":I
    :cond_a
    return-void
.end method

.method private static final showFloatingBall$lambda$2(Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;Landroid/view/View;)V
    .locals 5
    .param p0, "this$0"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;
    .param p1, "it"    # Landroid/view/View;

    const-string/jumbo v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 135
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->floatingView:Landroid/view/View;

    if-eqz v0, :cond_0

    sget v1, Lcom/rokid/security/phone/sdk/server/R$id;->tv_status:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 136
    .local v0, "tv":Landroid/widget/TextView;
    :goto_0
    const-string/jumbo v1, "\u7a7a\u95f2"

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v2

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    if-nez v2, :cond_2

    :cond_1
    move-object v2, v1

    .line 137
    .local v2, "cur":Ljava/lang/String;
    :cond_2
    nop

    .line 138
    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    const-string/jumbo v4, "\u5de1\u68c0\u4e2d"

    if-eqz v3, :cond_3

    move-object v1, v4

    goto :goto_1

    .line 139
    :cond_3
    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    const-string/jumbo v1, "\u6570\u636e\u4e0a\u4f20\u4e2d"

    goto :goto_1

    .line 141
    :cond_4
    nop

    .line 137
    :goto_1
    nop

    .line 143
    .local v1, "next":Ljava/lang/String;
    invoke-direct {p0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->updateStatus(Ljava/lang/String;)V

    .line 144
    return-void
.end method

.method private final updateStatus(Ljava/lang/String;)V
    .locals 3
    .param p1, "newStatus"    # Ljava/lang/String;

    .line 165
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "bollEvent state :"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 166
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->floatingView:Landroid/view/View;

    if-eqz v0, :cond_0

    sget v1, Lcom/rokid/security/phone/sdk/server/R$id;->tv_status:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 167
    .local v0, "tv":Landroid/widget/TextView;
    :goto_0
    if-nez v0, :cond_1

    goto :goto_1

    :cond_1
    move-object v1, p1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 168
    :goto_1
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->updateVisualStyle(Ljava/lang/String;)V

    .line 170
    return-void
.end method

.method private final updateVisualStyle(Ljava/lang/String;)V
    .locals 7
    .param p1, "status"    # Ljava/lang/String;

    .line 173
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->floatingView:Landroid/view/View;

    if-eqz v0, :cond_0

    sget v1, Lcom/rokid/security/phone/sdk/server/R$id;->ll_container:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-nez v0, :cond_1

    return-void

    .local v0, "bgView":Landroid/view/View;
    :cond_1
    const/4 v1, 0x0

    .local v1, "colorFrom":I
    const/4 v2, 0x0

    .line 177
    .local v2, "colorTo":I
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v3

    sparse-switch v3, :sswitch_data_0

    :goto_1
    goto :goto_2

    :sswitch_0
    const-string/jumbo v3, "\u5de1\u68c0\u4e2d"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    goto :goto_1

    .line 183
    :cond_2
    move-object v3, p0

    check-cast v3, Landroid/content/Context;

    sget v4, Lcom/rokid/security/phone/sdk/server/R$color;->blue:I

    invoke-static {v3, v4}, Landroidx/core/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result v1

    .line 184
    move-object v3, p0

    check-cast v3, Landroid/content/Context;

    sget v4, Lcom/rokid/security/phone/sdk/server/R$color;->blue_light:I

    invoke-static {v3, v4}, Landroidx/core/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result v2

    goto :goto_3

    .line 177
    :sswitch_1
    const-string/jumbo v3, "\u7a7a\u95f2"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    goto :goto_1

    .line 179
    :cond_3
    move-object v3, p0

    check-cast v3, Landroid/content/Context;

    sget v4, Lcom/rokid/security/phone/sdk/server/R$color;->gray:I

    invoke-static {v3, v4}, Landroidx/core/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result v1

    .line 180
    move-object v3, p0

    check-cast v3, Landroid/content/Context;

    sget v4, Lcom/rokid/security/phone/sdk/server/R$color;->gray_light:I

    invoke-static {v3, v4}, Landroidx/core/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result v2

    goto :goto_3

    .line 177
    :sswitch_2
    const-string/jumbo v3, "\u6570\u636e\u4e0a\u4f20\u4e2d"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_4

    goto :goto_1

    .line 187
    :cond_4
    move-object v3, p0

    check-cast v3, Landroid/content/Context;

    sget v4, Lcom/rokid/security/phone/sdk/server/R$color;->orange:I

    invoke-static {v3, v4}, Landroidx/core/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result v1

    .line 188
    move-object v3, p0

    check-cast v3, Landroid/content/Context;

    sget v4, Lcom/rokid/security/phone/sdk/server/R$color;->orange_light:I

    invoke-static {v3, v4}, Landroidx/core/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result v2

    goto :goto_3

    .line 191
    :goto_2
    move-object v3, p0

    check-cast v3, Landroid/content/Context;

    sget v4, Lcom/rokid/security/phone/sdk/server/R$color;->gray:I

    invoke-static {v3, v4}, Landroidx/core/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result v1

    .line 192
    move-object v3, p0

    check-cast v3, Landroid/content/Context;

    sget v4, Lcom/rokid/security/phone/sdk/server/R$color;->gray_light:I

    invoke-static {v3, v4}, Landroidx/core/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result v2

    .line 197
    :goto_3
    invoke-virtual {v0}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v3

    .line 198
    .local v3, "bgDrawable":Landroid/graphics/drawable/Drawable;
    instance-of v4, v3, Landroid/graphics/drawable/GradientDrawable;

    if-eqz v4, :cond_5

    .line 199
    new-instance v4, Landroid/animation/ArgbEvaluator;

    invoke-direct {v4}, Landroid/animation/ArgbEvaluator;-><init>()V

    check-cast v4, Landroid/animation/TypeEvaluator;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    filled-new-array {v5, v6}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/animation/ValueAnimator;->ofObject(Landroid/animation/TypeEvaluator;[Ljava/lang/Object;)Landroid/animation/ValueAnimator;

    move-result-object v4

    .line 200
    .local v4, "animator":Landroid/animation/ValueAnimator;
    const-wide/16 v5, 0x12c

    invoke-virtual {v4, v5, v6}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 201
    new-instance v5, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$$ExternalSyntheticLambda1;

    invoke-direct {v5, v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$$ExternalSyntheticLambda1;-><init>(Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {v4, v5}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 205
    invoke-virtual {v4}, Landroid/animation/ValueAnimator;->start()V

    .line 208
    .end local v4    # "animator":Landroid/animation/ValueAnimator;
    :cond_5
    return-void

    :sswitch_data_0
    .sparse-switch
        -0x3c2e3e27 -> :sswitch_2
        0xf6ab8 -> :sswitch_1
        0x16d670e -> :sswitch_0
    .end sparse-switch
.end method

.method private static final updateVisualStyle$lambda$5(Landroid/graphics/drawable/Drawable;Landroid/animation/ValueAnimator;)V
    .locals 2
    .param p0, "$bgDrawable"    # Landroid/graphics/drawable/Drawable;
    .param p1, "animation"    # Landroid/animation/ValueAnimator;

    const-string v0, "animation"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 202
    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->getAnimatedValue()Ljava/lang/Object;

    move-result-object v0

    const-string v1, "null cannot be cast to non-null type kotlin.Int"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 203
    .local v0, "color":I
    move-object v1, p0

    check-cast v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-virtual {v1, v0}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 204
    return-void
.end method


# virtual methods
.method public final getTAG()Ljava/lang/String;
    .locals 1

    .line 37
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;

    .line 215
    const/4 v0, 0x0

    return-object v0
.end method

.method public onCreate()V
    .locals 4

    .line 43
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 44
    const-string/jumbo v0, "window"

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    const-string v1, "null cannot be cast to non-null type android.view.WindowManager"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Landroid/view/WindowManager;

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->windowManager:Landroid/view/WindowManager;

    .line 45
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    .line 46
    new-instance v0, Landroid/app/NotificationChannel;

    .line 47
    nop

    .line 48
    const-string/jumbo v1, "\u60ac\u6d6e\u7403"

    check-cast v1, Ljava/lang/CharSequence;

    .line 49
    nop

    .line 46
    const-string v2, "floating_ball_channel"

    const/4 v3, 0x2

    invoke-direct {v0, v2, v1, v3}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    .line 51
    .local v0, "channel":Landroid/app/NotificationChannel;
    const-class v1, Landroid/app/NotificationManager;

    invoke-virtual {p0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/NotificationManager;

    .line 52
    .local v1, "manager":Landroid/app/NotificationManager;
    invoke-virtual {v1, v0}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    .line 53
    invoke-virtual {v0}, Landroid/app/NotificationChannel;->getId()Ljava/lang/String;

    move-result-object v0

    .end local v0    # "channel":Landroid/app/NotificationChannel;
    .end local v1    # "manager":Landroid/app/NotificationManager;
    goto :goto_0

    .line 55
    :cond_0
    const-string v0, ""

    .line 45
    :goto_0
    nop

    .line 58
    .local v0, "channelId":Ljava/lang/String;
    new-instance v1, Landroidx/core/app/NotificationCompat$Builder;

    move-object v2, p0

    check-cast v2, Landroid/content/Context;

    invoke-direct {v1, v2, v0}, Landroidx/core/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    .line 59
    const-string v2, "AI\u5de5\u4f5c\u52a9\u624b"

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Landroidx/core/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v1

    .line 60
    const-string/jumbo v2, "\u6b63\u5728\u8fd0\u884c"

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Landroidx/core/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v1

    .line 61
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroidx/core/app/NotificationCompat$Builder;->setOngoing(Z)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v1

    .line 62
    invoke-virtual {v1}, Landroidx/core/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    const-string v3, "Builder(this, channelId)\u2026rue)\n            .build()"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 58
    nop

    .line 63
    .local v1, "notification":Landroid/app/Notification;
    invoke-virtual {p0, v2, v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->startForeground(ILandroid/app/Notification;)V

    .line 64
    return-void
.end method

.method public onDestroy()V
    .locals 0

    .line 211
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->hideFloatingBall()V

    .line 212
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    .line 213
    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 5
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "flags"    # I
    .param p3, "startId"    # I

    .line 67
    const-string/jumbo v0, "\u5de1\u68c0\u4e2d"

    if-eqz p1, :cond_4

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_4

    .local v1, "action":Ljava/lang/String;
    const/4 v2, 0x0

    .line 68
    .local v2, "$i$a$-let-InspectBoll$onStartCommand$1":I
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v3

    sparse-switch v3, :sswitch_data_0

    :cond_0
    :goto_0
    goto :goto_2

    :sswitch_0
    const-string v3, "com.example.floatingball.ACTION_SHOW"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 69
    invoke-direct {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->showFloatingBall(Ljava/lang/String;)V

    goto :goto_2

    .line 68
    :sswitch_1
    const-string v3, "com.example.floatingball.ACTION_HIDE"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    goto :goto_0

    .line 70
    :cond_1
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->hideFloatingBall()V

    goto :goto_2

    .line 68
    :sswitch_2
    const-string v3, "com.example.floatingball.ACTION_UPDATE_STATUS"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    goto :goto_0

    .line 72
    :cond_2
    const-string v3, "extra_status"

    invoke-virtual {p1, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 73
    .local v3, "newStatus":Ljava/lang/String;
    if-nez v3, :cond_3

    move-object v4, v0

    goto :goto_1

    :cond_3
    move-object v4, v3

    :goto_1
    invoke-direct {p0, v4}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->updateStatus(Ljava/lang/String;)V

    .line 76
    .end local v3    # "newStatus":Ljava/lang/String;
    :goto_2
    nop

    .line 67
    .end local v1    # "action":Ljava/lang/String;
    .end local v2    # "$i$a$-let-InspectBoll$onStartCommand$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    goto :goto_3

    :cond_4
    const/4 v1, 0x0

    :goto_3
    if-nez v1, :cond_5

    .line 76
    move-object v1, p0

    check-cast v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;

    .local v1, "$this$onStartCommand_u24lambda_u241":Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;
    const/4 v2, 0x0

    .line 77
    .local v2, "$i$a$-run-InspectBoll$onStartCommand$2":I
    invoke-direct {v1, v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->showFloatingBall(Ljava/lang/String;)V

    .line 78
    nop

    .line 76
    .end local v1    # "$this$onStartCommand_u24lambda_u241":Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;
    .end local v2    # "$i$a$-run-InspectBoll$onStartCommand$2":I
    nop

    .line 80
    :cond_5
    const/4 v0, 0x1

    return v0

    :sswitch_data_0
    .sparse-switch
        -0x77df6a89 -> :sswitch_2
        0x31528b13 -> :sswitch_1
        0x315788ce -> :sswitch_0
    .end sparse-switch
.end method
