.class public Lcom/rokid/utils/RKPool;
.super Ljava/lang/Object;
.source "RKPool.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# instance fields
.field private clazz:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "TT;>;"
        }
    .end annotation
.end field

.field private mPools:Landroid/util/Pools$SimplePool;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/Pools$SimplePool<",
            "TT;>;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/Class;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "TT;>;)V"
        }
    .end annotation

    .line 18
    .local p0, "this":Lcom/rokid/utils/RKPool;, "Lcom/rokid/utils/RKPool<TT;>;"
    .local p1, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<TT;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 15
    new-instance v0, Landroid/util/Pools$SimplePool;

    const/16 v1, 0x28

    invoke-direct {v0, v1}, Landroid/util/Pools$SimplePool;-><init>(I)V

    iput-object v0, p0, Lcom/rokid/utils/RKPool;->mPools:Landroid/util/Pools$SimplePool;

    .line 19
    iput-object p1, p0, Lcom/rokid/utils/RKPool;->clazz:Ljava/lang/Class;

    .line 20
    return-void
.end method


# virtual methods
.method public obtain()Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    .line 23
    .local p0, "this":Lcom/rokid/utils/RKPool;, "Lcom/rokid/utils/RKPool<TT;>;"
    iget-object v0, p0, Lcom/rokid/utils/RKPool;->mPools:Landroid/util/Pools$SimplePool;

    invoke-virtual {v0}, Landroid/util/Pools$SimplePool;->acquire()Ljava/lang/Object;

    move-result-object v0

    .line 25
    .local v0, "acquire":Ljava/lang/Object;, "TT;"
    if-nez v0, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/rokid/utils/RKPool;->clazz:Ljava/lang/Class;

    invoke-virtual {v1}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 26
    :catch_0
    move-exception v1

    goto :goto_0

    :catch_1
    move-exception v1

    .line 27
    .local v1, "e":Ljava/lang/ReflectiveOperationException;
    :goto_0
    invoke-virtual {v1}, Ljava/lang/ReflectiveOperationException;->printStackTrace()V

    .line 29
    .end local v1    # "e":Ljava/lang/ReflectiveOperationException;
    const/4 v1, 0x0

    return-object v1

    .line 25
    :cond_0
    move-object v1, v0

    :goto_1
    return-object v1
.end method

.method public recycle(Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation

    .line 33
    .local p0, "this":Lcom/rokid/utils/RKPool;, "Lcom/rokid/utils/RKPool<TT;>;"
    .local p1, "t":Ljava/lang/Object;, "TT;"
    if-nez p1, :cond_0

    return-void

    .line 34
    :cond_0
    iget-object v0, p0, Lcom/rokid/utils/RKPool;->mPools:Landroid/util/Pools$SimplePool;

    invoke-virtual {v0, p1}, Landroid/util/Pools$SimplePool;->release(Ljava/lang/Object;)Z

    .line 35
    return-void
.end method
