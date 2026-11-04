.class public abstract Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;
.super Ljava/lang/Object;
.source "TouchUtils.java"

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/blankj/utilcode/util/TouchUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "OnTouchUtilsListener"
.end annotation


# static fields
.field private static final MIN_TAP_TIME:I = 0x3e8

.field private static final STATE_DOWN:I = 0x0

.field private static final STATE_MOVE:I = 0x1

.field private static final STATE_STOP:I = 0x2


# instance fields
.field private direction:I

.field private downX:I

.field private downY:I

.field private lastX:I

.field private lastY:I

.field private maximumFlingVelocity:I

.field private minimumFlingVelocity:I

.field private state:I

.field private touchSlop:I

.field private velocityTracker:Landroid/view/VelocityTracker;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 61
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 62
    const/4 v0, -0x1

    invoke-direct {p0, v0, v0}, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->resetTouch(II)V

    .line 63
    return-void
.end method

.method private resetTouch(II)V
    .locals 1
    .param p1, "x"    # I
    .param p2, "y"    # I

    .line 66
    iput p1, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->downX:I

    .line 67
    iput p2, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->downY:I

    .line 68
    iput p1, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->lastX:I

    .line 69
    iput p2, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->lastY:I

    .line 70
    const/4 v0, 0x0

    iput v0, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->state:I

    .line 71
    iput v0, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->direction:I

    .line 72
    iget-object v0, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->velocityTracker:Landroid/view/VelocityTracker;

    if-eqz v0, :cond_0

    .line 73
    iget-object v0, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->velocityTracker:Landroid/view/VelocityTracker;

    invoke-virtual {v0}, Landroid/view/VelocityTracker;->clear()V

    .line 75
    :cond_0
    return-void
.end method


# virtual methods
.method public abstract onDown(Landroid/view/View;IILandroid/view/MotionEvent;)Z
.end method

.method public abstract onMove(Landroid/view/View;IIIIIIILandroid/view/MotionEvent;)Z
.end method

.method public abstract onStop(Landroid/view/View;IIIIIIILandroid/view/MotionEvent;)Z
.end method

.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "v"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .line 101
    iget v0, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->touchSlop:I

    if-nez v0, :cond_0

    .line 102
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewConfiguration;->getScaledTouchSlop()I

    move-result v0

    iput v0, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->touchSlop:I

    .line 104
    :cond_0
    iget v0, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->maximumFlingVelocity:I

    if-nez v0, :cond_1

    .line 105
    nop

    .line 106
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewConfiguration;->getScaledMaximumFlingVelocity()I

    move-result v0

    iput v0, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->maximumFlingVelocity:I

    .line 108
    :cond_1
    iget v0, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->minimumFlingVelocity:I

    if-nez v0, :cond_2

    .line 109
    nop

    .line 110
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewConfiguration;->getScaledMinimumFlingVelocity()I

    move-result v0

    iput v0, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->minimumFlingVelocity:I

    .line 112
    :cond_2
    iget-object v0, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->velocityTracker:Landroid/view/VelocityTracker;

    if-nez v0, :cond_3

    .line 113
    invoke-static {}, Landroid/view/VelocityTracker;->obtain()Landroid/view/VelocityTracker;

    move-result-object v0

    iput-object v0, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->velocityTracker:Landroid/view/VelocityTracker;

    .line 115
    :cond_3
    iget-object v0, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->velocityTracker:Landroid/view/VelocityTracker;

    invoke-virtual {v0, p2}, Landroid/view/VelocityTracker;->addMovement(Landroid/view/MotionEvent;)V

    .line 117
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 128
    const/4 v0, 0x0

    return v0

    .line 121
    :pswitch_0
    invoke-virtual {p0, p1, p2}, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->onUtilsMove(Landroid/view/View;Landroid/view/MotionEvent;)Z

    move-result v0

    return v0

    .line 124
    :pswitch_1
    invoke-virtual {p0, p1, p2}, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->onUtilsStop(Landroid/view/View;Landroid/view/MotionEvent;)Z

    move-result v0

    return v0

    .line 119
    :pswitch_2
    invoke-virtual {p0, p1, p2}, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->onUtilsDown(Landroid/view/View;Landroid/view/MotionEvent;)Z

    move-result v0

    return v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public onUtilsDown(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 3
    .param p1, "view"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .line 132
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result v0

    float-to-int v0, v0

    .line 133
    .local v0, "x":I
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result v1

    float-to-int v1, v1

    .line 135
    .local v1, "y":I
    invoke-direct {p0, v0, v1}, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->resetTouch(II)V

    .line 136
    const/4 v2, 0x1

    invoke-virtual {p1, v2}, Landroid/view/View;->setPressed(Z)V

    .line 137
    invoke-virtual {p0, p1, v0, v1, p2}, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->onDown(Landroid/view/View;IILandroid/view/MotionEvent;)Z

    move-result v2

    return v2
.end method

.method public onUtilsMove(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 12
    .param p1, "view"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .line 141
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result v0

    float-to-int v0, v0

    .line 142
    .local v0, "x":I
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result v1

    float-to-int v11, v1

    .line 144
    .local v11, "y":I
    iget v1, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->downX:I

    const/4 v2, -0x1

    const/4 v3, 0x1

    if-ne v1, v2, :cond_0

    .line 146
    invoke-direct {p0, v0, v11}, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->resetTouch(II)V

    .line 147
    invoke-virtual {p1, v3}, Landroid/view/View;->setPressed(Z)V

    .line 150
    :cond_0
    iget v1, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->state:I

    if-eq v1, v3, :cond_5

    .line 151
    iget v1, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->lastX:I

    sub-int v1, v0, v1

    invoke-static {v1}, Ljava/lang/Math;->abs(I)I

    move-result v1

    iget v2, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->touchSlop:I

    if-ge v1, v2, :cond_1

    iget v1, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->lastY:I

    sub-int v1, v11, v1

    invoke-static {v1}, Ljava/lang/Math;->abs(I)I

    move-result v1

    iget v2, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->touchSlop:I

    if-ge v1, v2, :cond_1

    .line 152
    return v3

    .line 154
    :cond_1
    iput v3, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->state:I

    .line 155
    iget v1, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->lastX:I

    sub-int v1, v0, v1

    invoke-static {v1}, Ljava/lang/Math;->abs(I)I

    move-result v1

    iget v2, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->lastY:I

    sub-int v2, v11, v2

    invoke-static {v2}, Ljava/lang/Math;->abs(I)I

    move-result v2

    if-lt v1, v2, :cond_3

    .line 156
    iget v1, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->lastX:I

    sub-int v1, v0, v1

    if-gez v1, :cond_2

    .line 157
    iput v3, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->direction:I

    goto :goto_0

    .line 159
    :cond_2
    const/4 v1, 0x4

    iput v1, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->direction:I

    goto :goto_0

    .line 162
    :cond_3
    iget v1, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->lastY:I

    sub-int v1, v11, v1

    if-gez v1, :cond_4

    .line 163
    const/4 v1, 0x2

    iput v1, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->direction:I

    goto :goto_0

    .line 165
    :cond_4
    const/16 v1, 0x8

    iput v1, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->direction:I

    .line 170
    :cond_5
    :goto_0
    iget v3, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->direction:I

    iget v1, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->lastX:I

    sub-int v6, v0, v1

    iget v1, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->lastY:I

    sub-int v7, v11, v1

    iget v1, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->downX:I

    sub-int v8, v0, v1

    iget v1, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->downY:I

    sub-int v9, v11, v1

    .line 171
    move-object v1, p0

    move-object v2, p1

    move v4, v0

    move v5, v11

    move-object v10, p2

    invoke-virtual/range {v1 .. v10}, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->onMove(Landroid/view/View;IIIIIIILandroid/view/MotionEvent;)Z

    move-result v1

    .line 172
    .local v1, "consumeMove":Z
    iput v0, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->lastX:I

    .line 173
    iput v11, p0, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->lastY:I

    .line 174
    return v1
.end method

.method public onUtilsStop(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 16
    .param p1, "view"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .line 178
    move-object/from16 v10, p0

    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result v0

    float-to-int v11, v0

    .line 179
    .local v11, "x":I
    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result v0

    float-to-int v12, v0

    .line 181
    .local v12, "y":I
    const/4 v0, 0x0

    .local v0, "vx":I
    const/4 v1, 0x0

    .line 183
    .local v1, "vy":I
    iget-object v2, v10, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->velocityTracker:Landroid/view/VelocityTracker;

    if-eqz v2, :cond_2

    .line 184
    iget-object v2, v10, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->velocityTracker:Landroid/view/VelocityTracker;

    iget v3, v10, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->maximumFlingVelocity:I

    int-to-float v3, v3

    const/16 v4, 0x3e8

    invoke-virtual {v2, v4, v3}, Landroid/view/VelocityTracker;->computeCurrentVelocity(IF)V

    .line 185
    iget-object v2, v10, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->velocityTracker:Landroid/view/VelocityTracker;

    invoke-virtual {v2}, Landroid/view/VelocityTracker;->getXVelocity()F

    move-result v2

    float-to-int v0, v2

    .line 186
    iget-object v2, v10, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->velocityTracker:Landroid/view/VelocityTracker;

    invoke-virtual {v2}, Landroid/view/VelocityTracker;->getYVelocity()F

    move-result v2

    float-to-int v1, v2

    .line 187
    iget-object v2, v10, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->velocityTracker:Landroid/view/VelocityTracker;

    invoke-virtual {v2}, Landroid/view/VelocityTracker;->recycle()V

    .line 188
    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v2

    iget v3, v10, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->minimumFlingVelocity:I

    if-ge v2, v3, :cond_0

    .line 189
    const/4 v0, 0x0

    .line 191
    :cond_0
    invoke-static {v1}, Ljava/lang/Math;->abs(I)I

    move-result v2

    iget v3, v10, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->minimumFlingVelocity:I

    if-ge v2, v3, :cond_1

    .line 192
    const/4 v1, 0x0

    .line 194
    :cond_1
    const/4 v2, 0x0

    iput-object v2, v10, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->velocityTracker:Landroid/view/VelocityTracker;

    move v13, v0

    move v14, v1

    goto :goto_0

    .line 183
    :cond_2
    move v13, v0

    move v14, v1

    .line 197
    .end local v0    # "vx":I
    .end local v1    # "vy":I
    .local v13, "vx":I
    .local v14, "vy":I
    :goto_0
    const/4 v0, 0x0

    move-object/from16 v15, p1

    invoke-virtual {v15, v0}, Landroid/view/View;->setPressed(Z)V

    .line 198
    iget v2, v10, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->direction:I

    iget v0, v10, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->downX:I

    sub-int v5, v11, v0

    iget v0, v10, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->downY:I

    sub-int v6, v12, v0

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v3, v11

    move v4, v12

    move v7, v13

    move v8, v14

    move-object/from16 v9, p2

    invoke-virtual/range {v0 .. v9}, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->onStop(Landroid/view/View;IIIIIIILandroid/view/MotionEvent;)Z

    move-result v0

    .line 200
    .local v0, "consumeStop":Z
    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_4

    .line 201
    iget v1, v10, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->state:I

    if-nez v1, :cond_4

    .line 202
    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v1

    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getDownTime()J

    move-result-wide v3

    sub-long/2addr v1, v3

    const-wide/16 v3, 0x3e8

    cmp-long v1, v1, v3

    if-gtz v1, :cond_3

    .line 203
    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->performClick()Z

    goto :goto_1

    .line 205
    :cond_3
    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->performLongClick()Z

    .line 210
    :cond_4
    :goto_1
    const/4 v1, -0x1

    invoke-direct {v10, v1, v1}, Lcom/blankj/utilcode/util/TouchUtils$OnTouchUtilsListener;->resetTouch(II)V

    .line 212
    return v0
.end method
