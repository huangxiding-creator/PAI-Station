.class final Lcom/bumptech/glide/manager/FirstFrameWaiter;
.super Ljava/lang/Object;
.source "FirstFrameWaiter.java"

# interfaces
.implements Lcom/bumptech/glide/manager/FrameWaiter;


# instance fields
.field volatile isFirstFrameSet:Z

.field final pendingActivities:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Landroid/app/Activity;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>()V
    .locals 1

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    .line 20
    invoke-static {v0}, Ljava/util/Collections;->newSetFromMap(Ljava/util/Map;)Ljava/util/Set;

    move-result-object v0

    iput-object v0, p0, Lcom/bumptech/glide/manager/FirstFrameWaiter;->pendingActivities:Ljava/util/Set;

    .line 18
    return-void
.end method

.method static removeListener(Landroid/view/View;Landroid/view/ViewTreeObserver$OnDrawListener;)V
    .locals 1
    .param p0, "view"    # Landroid/view/View;
    .param p1, "listener"    # Landroid/view/ViewTreeObserver$OnDrawListener;

    .line 65
    invoke-virtual {p0}, Landroid/view/View;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v0

    .line 66
    .local v0, "currentViewTreeObserver":Landroid/view/ViewTreeObserver;
    invoke-virtual {v0, p1}, Landroid/view/ViewTreeObserver;->removeOnDrawListener(Landroid/view/ViewTreeObserver$OnDrawListener;)V

    .line 67
    return-void
.end method


# virtual methods
.method public registerSelf(Landroid/app/Activity;)V
    .locals 3
    .param p1, "activity"    # Landroid/app/Activity;

    .line 29
    iget-boolean v0, p0, Lcom/bumptech/glide/manager/FirstFrameWaiter;->isFirstFrameSet:Z

    if-eqz v0, :cond_0

    .line 30
    return-void

    .line 32
    :cond_0
    iget-object v0, p0, Lcom/bumptech/glide/manager/FirstFrameWaiter;->pendingActivities:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 33
    return-void

    .line 36
    :cond_1
    invoke-virtual {p1}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    .line 37
    .local v0, "view":Landroid/view/View;
    invoke-virtual {v0}, Landroid/view/View;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v1

    .line 38
    .local v1, "viewTreeObserver":Landroid/view/ViewTreeObserver;
    new-instance v2, Lcom/bumptech/glide/manager/FirstFrameWaiter$1;

    invoke-direct {v2, p0, v0}, Lcom/bumptech/glide/manager/FirstFrameWaiter$1;-><init>(Lcom/bumptech/glide/manager/FirstFrameWaiter;Landroid/view/View;)V

    invoke-virtual {v1, v2}, Landroid/view/ViewTreeObserver;->addOnDrawListener(Landroid/view/ViewTreeObserver$OnDrawListener;)V

    .line 57
    return-void
.end method
