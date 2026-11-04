.class public abstract Lcom/rokid/utils/RKSingleton;
.super Ljava/lang/Object;
.source "RKSingleton.java"


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
.field obj:Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TT;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 12
    .local p0, "this":Lcom/rokid/utils/RKSingleton;, "Lcom/rokid/utils/RKSingleton<TT;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract create()Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation
.end method

.method public get()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    .line 24
    .local p0, "this":Lcom/rokid/utils/RKSingleton;, "Lcom/rokid/utils/RKSingleton<TT;>;"
    iget-object v0, p0, Lcom/rokid/utils/RKSingleton;->obj:Ljava/lang/Object;

    if-nez v0, :cond_1

    .line 25
    monitor-enter p0

    .line 26
    :try_start_0
    iget-object v0, p0, Lcom/rokid/utils/RKSingleton;->obj:Ljava/lang/Object;

    if-nez v0, :cond_0

    .line 27
    invoke-virtual {p0}, Lcom/rokid/utils/RKSingleton;->create()Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/utils/RKSingleton;->obj:Ljava/lang/Object;

    .line 29
    :cond_0
    monitor-exit p0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 31
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/rokid/utils/RKSingleton;->obj:Ljava/lang/Object;

    return-object v0
.end method
