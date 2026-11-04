.class public abstract Lcom/blankj/utilcode/util/UtilsTransActivity$TransActivityDelegate;
.super Ljava/lang/Object;
.source "UtilsTransActivity.java"

# interfaces
.implements Ljava/io/Serializable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/blankj/utilcode/util/UtilsTransActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "TransActivityDelegate"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 160
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public dispatchTouchEvent(Lcom/blankj/utilcode/util/UtilsTransActivity;Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "activity"    # Lcom/blankj/utilcode/util/UtilsTransActivity;
    .param p2, "ev"    # Landroid/view/MotionEvent;

    .line 182
    const/4 v0, 0x0

    return v0
.end method

.method public onActivityResult(Lcom/blankj/utilcode/util/UtilsTransActivity;IILandroid/content/Intent;)V
    .locals 0
    .param p1, "activity"    # Lcom/blankj/utilcode/util/UtilsTransActivity;
    .param p2, "requestCode"    # I
    .param p3, "resultCode"    # I
    .param p4, "data"    # Landroid/content/Intent;

    .line 179
    return-void
.end method

.method public onCreateBefore(Lcom/blankj/utilcode/util/UtilsTransActivity;Landroid/os/Bundle;)V
    .locals 0
    .param p1, "activity"    # Lcom/blankj/utilcode/util/UtilsTransActivity;
    .param p2, "savedInstanceState"    # Landroid/os/Bundle;

    .line 161
    return-void
.end method

.method public onCreated(Lcom/blankj/utilcode/util/UtilsTransActivity;Landroid/os/Bundle;)V
    .locals 0
    .param p1, "activity"    # Lcom/blankj/utilcode/util/UtilsTransActivity;
    .param p2, "savedInstanceState"    # Landroid/os/Bundle;

    .line 163
    return-void
.end method

.method public onDestroy(Lcom/blankj/utilcode/util/UtilsTransActivity;)V
    .locals 0
    .param p1, "activity"    # Lcom/blankj/utilcode/util/UtilsTransActivity;

    .line 167
    return-void
.end method

.method public onPaused(Lcom/blankj/utilcode/util/UtilsTransActivity;)V
    .locals 0
    .param p1, "activity"    # Lcom/blankj/utilcode/util/UtilsTransActivity;

    .line 171
    return-void
.end method

.method public onRequestPermissionsResult(Lcom/blankj/utilcode/util/UtilsTransActivity;I[Ljava/lang/String;[I)V
    .locals 0
    .param p1, "activity"    # Lcom/blankj/utilcode/util/UtilsTransActivity;
    .param p2, "requestCode"    # I
    .param p3, "permissions"    # [Ljava/lang/String;
    .param p4, "grantResults"    # [I

    .line 177
    return-void
.end method

.method public onResumed(Lcom/blankj/utilcode/util/UtilsTransActivity;)V
    .locals 0
    .param p1, "activity"    # Lcom/blankj/utilcode/util/UtilsTransActivity;

    .line 169
    return-void
.end method

.method public onSaveInstanceState(Lcom/blankj/utilcode/util/UtilsTransActivity;Landroid/os/Bundle;)V
    .locals 0
    .param p1, "activity"    # Lcom/blankj/utilcode/util/UtilsTransActivity;
    .param p2, "outState"    # Landroid/os/Bundle;

    .line 175
    return-void
.end method

.method public onStarted(Lcom/blankj/utilcode/util/UtilsTransActivity;)V
    .locals 0
    .param p1, "activity"    # Lcom/blankj/utilcode/util/UtilsTransActivity;

    .line 165
    return-void
.end method

.method public onStopped(Lcom/blankj/utilcode/util/UtilsTransActivity;)V
    .locals 0
    .param p1, "activity"    # Lcom/blankj/utilcode/util/UtilsTransActivity;

    .line 173
    return-void
.end method
