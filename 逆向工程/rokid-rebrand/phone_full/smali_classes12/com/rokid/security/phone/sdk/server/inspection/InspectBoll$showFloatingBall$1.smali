.class public final Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;
.super Ljava/lang/Object;
.source "InspectBoll.kt"

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->showFloatingBall(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nInspectBoll.kt\nKotlin\n*S Kotlin\n*F\n+ 1 InspectBoll.kt\ncom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,218:1\n1#2:219\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000-\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0007\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0018\u0010\u0008\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\u000b2\u0006\u0010\u000c\u001a\u00020\rH\u0016R\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0004\u001a\u00020\u0003X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000e"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1",
        "Landroid/view/View$OnTouchListener;",
        "downX",
        "",
        "downY",
        "lastX",
        "",
        "lastY",
        "onTouch",
        "",
        "v",
        "Landroid/view/View;",
        "event",
        "Landroid/view/MotionEvent;",
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


# instance fields
.field private downX:F

.field private downY:F

.field private lastX:I

.field private lastY:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;

    .line 106
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 8
    .param p1, "v"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    const-string/jumbo v0, "v"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "event"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 112
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    packed-switch v0, :pswitch_data_0

    .line 129
    :pswitch_0
    return v2

    .line 121
    :pswitch_1
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result v0

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;->downX:F

    sub-float/2addr v0, v2

    float-to-int v0, v0

    .line 122
    .local v0, "dx":I
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result v2

    iget v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;->downY:F

    sub-float/2addr v2, v3

    float-to-int v2, v2

    .line 123
    .local v2, "dy":I
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->access$getParams$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v3

    if-nez v3, :cond_0

    goto :goto_0

    :cond_0
    iget v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;->lastX:I

    add-int/2addr v4, v0

    iput v4, v3, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 124
    :goto_0
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->access$getParams$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_1

    :cond_1
    iget v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;->lastY:I

    add-int/2addr v4, v2

    iput v4, v3, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 125
    :goto_1
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->access$getParams$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v3

    if-eqz v3, :cond_3

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;

    .line 219
    .local v3, "it":Landroid/view/WindowManager$LayoutParams;
    const/4 v5, 0x0

    .line 125
    .local v5, "$i$a$-let-InspectBoll$showFloatingBall$1$onTouch$1":I
    invoke-static {v4}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->access$getWindowManager$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;)Landroid/view/WindowManager;

    move-result-object v6

    if-nez v6, :cond_2

    const-string/jumbo v6, "windowManager"

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v6, 0x0

    :cond_2
    invoke-static {v4}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->access$getFloatingView$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;)Landroid/view/View;

    move-result-object v4

    move-object v7, v3

    check-cast v7, Landroid/view/ViewGroup$LayoutParams;

    invoke-interface {v6, v4, v7}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 126
    .end local v3    # "it":Landroid/view/WindowManager$LayoutParams;
    .end local v5    # "$i$a$-let-InspectBoll$showFloatingBall$1$onTouch$1":I
    :cond_3
    return v1

    .line 114
    .end local v0    # "dx":I
    .end local v2    # "dy":I
    :pswitch_2
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->access$getParams$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    if-eqz v0, :cond_4

    iget v0, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    goto :goto_2

    :cond_4
    move v0, v2

    :goto_2
    iput v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;->lastX:I

    .line 115
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;->access$getParams$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    if-eqz v0, :cond_5

    iget v2, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    :cond_5
    iput v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;->lastY:I

    .line 116
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result v0

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;->downX:F

    .line 117
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result v0

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectBoll$showFloatingBall$1;->downY:F

    .line 118
    return v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
