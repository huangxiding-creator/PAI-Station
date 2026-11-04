.class public Lcom/amazonaws/event/ProgressListenerChain;
.super Ljava/lang/Object;
.source "ProgressListenerChain.java"

# interfaces
.implements Lcom/amazonaws/event/ProgressListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/amazonaws/event/ProgressListenerChain$ProgressEventFilter;
    }
.end annotation


# static fields
.field private static final log:Lcom/amazonaws/logging/Log;


# instance fields
.field private final listeners:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/event/ProgressListener;",
            ">;"
        }
    .end annotation
.end field

.field private final progressEventFilter:Lcom/amazonaws/event/ProgressListenerChain$ProgressEventFilter;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 40
    const-class v0, Lcom/amazonaws/event/ProgressListenerChain;

    invoke-static {v0}, Lcom/amazonaws/logging/LogFactory;->getLog(Ljava/lang/Class;)Lcom/amazonaws/logging/Log;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/event/ProgressListenerChain;->log:Lcom/amazonaws/logging/Log;

    return-void
.end method

.method public varargs constructor <init>(Lcom/amazonaws/event/ProgressListenerChain$ProgressEventFilter;[Lcom/amazonaws/event/ProgressListener;)V
    .locals 3
    .param p1, "progressEventFilter"    # Lcom/amazonaws/event/ProgressListenerChain$ProgressEventFilter;
    .param p2, "listeners"    # [Lcom/amazonaws/event/ProgressListener;

    .line 57
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/event/ProgressListenerChain;->listeners:Ljava/util/List;

    .line 58
    if-eqz p2, :cond_1

    .line 62
    array-length v0, p2

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    aget-object v2, p2, v1

    .line 63
    .local v2, "listener":Lcom/amazonaws/event/ProgressListener;
    invoke-virtual {p0, v2}, Lcom/amazonaws/event/ProgressListenerChain;->addProgressListener(Lcom/amazonaws/event/ProgressListener;)V

    .line 62
    .end local v2    # "listener":Lcom/amazonaws/event/ProgressListener;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 64
    :cond_0
    iput-object p1, p0, Lcom/amazonaws/event/ProgressListenerChain;->progressEventFilter:Lcom/amazonaws/event/ProgressListenerChain$ProgressEventFilter;

    .line 65
    return-void

    .line 59
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Progress Listeners cannot be null."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public varargs constructor <init>([Lcom/amazonaws/event/ProgressListener;)V
    .locals 1
    .param p1, "listeners"    # [Lcom/amazonaws/event/ProgressListener;

    .line 48
    const/4 v0, 0x0

    invoke-direct {p0, v0, p1}, Lcom/amazonaws/event/ProgressListenerChain;-><init>(Lcom/amazonaws/event/ProgressListenerChain$ProgressEventFilter;[Lcom/amazonaws/event/ProgressListener;)V

    .line 49
    return-void
.end method


# virtual methods
.method public declared-synchronized addProgressListener(Lcom/amazonaws/event/ProgressListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/amazonaws/event/ProgressListener;

    monitor-enter p0

    .line 72
    if-nez p1, :cond_0

    .line 73
    monitor-exit p0

    return-void

    .line 74
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/amazonaws/event/ProgressListenerChain;->listeners:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 75
    monitor-exit p0

    return-void

    .line 71
    .end local p0    # "this":Lcom/amazonaws/event/ProgressListenerChain;
    .end local p1    # "listener":Lcom/amazonaws/event/ProgressListener;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method protected getListeners()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/event/ProgressListener;",
            ">;"
        }
    .end annotation

    .line 91
    iget-object v0, p0, Lcom/amazonaws/event/ProgressListenerChain;->listeners:Ljava/util/List;

    return-object v0
.end method

.method public progressChanged(Lcom/amazonaws/event/ProgressEvent;)V
    .locals 6
    .param p1, "progressEvent"    # Lcom/amazonaws/event/ProgressEvent;

    .line 96
    move-object v0, p1

    .line 97
    .local v0, "filteredEvent":Lcom/amazonaws/event/ProgressEvent;
    iget-object v1, p0, Lcom/amazonaws/event/ProgressListenerChain;->progressEventFilter:Lcom/amazonaws/event/ProgressListenerChain$ProgressEventFilter;

    if-eqz v1, :cond_0

    .line 98
    iget-object v1, p0, Lcom/amazonaws/event/ProgressListenerChain;->progressEventFilter:Lcom/amazonaws/event/ProgressListenerChain$ProgressEventFilter;

    invoke-interface {v1, p1}, Lcom/amazonaws/event/ProgressListenerChain$ProgressEventFilter;->filter(Lcom/amazonaws/event/ProgressEvent;)Lcom/amazonaws/event/ProgressEvent;

    move-result-object v0

    .line 99
    if-nez v0, :cond_0

    .line 100
    return-void

    .line 103
    :cond_0
    iget-object v1, p0, Lcom/amazonaws/event/ProgressListenerChain;->listeners:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/amazonaws/event/ProgressListener;

    .line 105
    .local v2, "listener":Lcom/amazonaws/event/ProgressListener;
    :try_start_0
    invoke-interface {v2, v0}, Lcom/amazonaws/event/ProgressListener;->progressChanged(Lcom/amazonaws/event/ProgressEvent;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 108
    goto :goto_1

    .line 106
    :catch_0
    move-exception v3

    .line 107
    .local v3, "e":Ljava/lang/RuntimeException;
    sget-object v4, Lcom/amazonaws/event/ProgressListenerChain;->log:Lcom/amazonaws/logging/Log;

    const-string v5, "Couldn\'t update progress listener"

    invoke-interface {v4, v5, v3}, Lcom/amazonaws/logging/Log;->warn(Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 109
    .end local v2    # "listener":Lcom/amazonaws/event/ProgressListener;
    .end local v3    # "e":Ljava/lang/RuntimeException;
    :goto_1
    goto :goto_0

    .line 110
    :cond_1
    return-void
.end method

.method public declared-synchronized removeProgressListener(Lcom/amazonaws/event/ProgressListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/amazonaws/event/ProgressListener;

    monitor-enter p0

    .line 82
    if-nez p1, :cond_0

    .line 83
    monitor-exit p0

    return-void

    .line 84
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/amazonaws/event/ProgressListenerChain;->listeners:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 85
    monitor-exit p0

    return-void

    .line 81
    .end local p0    # "this":Lcom/amazonaws/event/ProgressListenerChain;
    .end local p1    # "listener":Lcom/amazonaws/event/ProgressListener;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method
