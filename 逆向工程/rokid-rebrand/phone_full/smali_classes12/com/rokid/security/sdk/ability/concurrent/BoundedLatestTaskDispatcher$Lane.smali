.class final Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;
.super Ljava/lang/Object;
.source "BoundedLatestTaskDispatcher.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "Lane"
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBoundedLatestTaskDispatcher.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BoundedLatestTaskDispatcher.kt\ncom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,226:1\n1#2:227\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000&\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0007\u0008\u0082\u0004\u0018\u00002\u00020\u0001B\r\u0012\u0006\u0010\u0002\u001a\u00028\u0000\u00a2\u0006\u0002\u0010\u0003J\u0006\u0010\u000e\u001a\u00020\u000cJ\u0008\u0010\u000f\u001a\u00020\u000cH\u0002J\u0016\u0010\u0010\u001a\u00020\u00072\u000c\u0010\u0011\u001a\u0008\u0012\u0004\u0012\u00020\u000c0\u000bH\u0002J\u0014\u0010\u0012\u001a\u00020\u00072\u000c\u0010\u0011\u001a\u0008\u0012\u0004\u0012\u00020\u000c0\u000bR\u0010\u0010\u0004\u001a\u0004\u0018\u00010\u0005X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0002\u001a\u00028\u0000X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\tR\u0016\u0010\n\u001a\n\u0012\u0004\u0012\u00020\u000c\u0018\u00010\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\r\u001a\u00020\u0001X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0013"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;",
        "",
        "key",
        "(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Ljava/lang/Object;)V",
        "activeWorker",
        "Ljava/lang/Thread;",
        "closed",
        "",
        "coordinatorRunning",
        "Ljava/lang/Object;",
        "latest",
        "Lkotlin/Function0;",
        "",
        "lock",
        "close",
        "drain",
        "runIsolated",
        "task",
        "submit",
        "sdk-common-ability_release"
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
.field private activeWorker:Ljava/lang/Thread;

.field private closed:Z

.field private coordinatorRunning:Z

.field private final key:Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TK;"
        }
    .end annotation
.end field

.field private latest:Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field private final lock:Ljava/lang/Object;

.field final synthetic this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher<",
            "TK;>;"
        }
    .end annotation
.end field


# direct methods
.method public static synthetic $r8$lambda$4rHmwCRvaPqK62lHrwX26abSHvw(Lkotlin/jvm/functions/Function0;Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;Ljava/util/concurrent/CountDownLatch;)V
    .locals 0

    invoke-static {p0, p1, p2, p3}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->runIsolated$lambda$6(Lkotlin/jvm/functions/Function0;Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;Ljava/util/concurrent/CountDownLatch;)V

    return-void
.end method

.method public static synthetic $r8$lambda$qwFn1k3oew9IL07lLjtoVxsb_7I(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;)V
    .locals 0

    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->drain()V

    return-void
.end method

.method public constructor <init>(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Ljava/lang/Object;)V
    .locals 1
    .param p1, "this$0"    # Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;
    .param p2, "key"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;)V"
        }
    .end annotation

    .line 104
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->key:Ljava/lang/Object;

    .line 105
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->lock:Ljava/lang/Object;

    .line 104
    return-void
.end method

.method private final drain()V
    .locals 8

    .line 140
    nop

    :cond_0
    nop

    .line 141
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->lock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    .line 142
    .local v1, "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$drain$task$1":I
    :try_start_0
    iget-boolean v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->closed:Z

    const/4 v3, 0x0

    if-eqz v2, :cond_1

    .line 143
    iput-boolean v3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->coordinatorRunning:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 144
    nop

    .end local v1    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$drain$task$1":I
    monitor-exit v0

    return-void

    .line 146
    .restart local v1    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$drain$task$1":I
    :cond_1
    :try_start_1
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->latest:Lkotlin/jvm/functions/Function0;

    move-object v4, v2

    .local v4, "next":Lkotlin/jvm/functions/Function0;
    const/4 v5, 0x0

    .line 147
    .local v5, "$i$a$-also-BoundedLatestTaskDispatcher$Lane$drain$task$1$1":I
    const/4 v6, 0x1

    const/4 v7, 0x0

    if-nez v4, :cond_2

    .line 151
    iput-boolean v6, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->closed:Z

    .line 152
    iput-boolean v3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->coordinatorRunning:Z

    goto :goto_0

    .line 154
    :cond_2
    iput-object v7, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->latest:Lkotlin/jvm/functions/Function0;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 156
    :goto_0
    nop

    .line 146
    .end local v4    # "next":Lkotlin/jvm/functions/Function0;
    .end local v5    # "$i$a$-also-BoundedLatestTaskDispatcher$Lane$drain$task$1$1":I
    nop

    .line 141
    .end local v1    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$drain$task$1":I
    monitor-exit v0

    move-object v0, v2

    .line 158
    .local v0, "task":Lkotlin/jvm/functions/Function0;
    if-nez v0, :cond_3

    .line 159
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    invoke-static {v1}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->access$getLanes$p(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;)Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->key:Ljava/lang/Object;

    invoke-virtual {v1, v2, p0}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 160
    return-void

    .line 162
    :cond_3
    invoke-direct {p0, v0}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->runIsolated(Lkotlin/jvm/functions/Function0;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 163
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->lock:Ljava/lang/Object;

    monitor-enter v1

    const/4 v2, 0x0

    .line 164
    .local v2, "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$drain$1":I
    :try_start_2
    iput-boolean v6, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->closed:Z

    .line 165
    iput-object v7, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->latest:Lkotlin/jvm/functions/Function0;

    .line 166
    iput-boolean v3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->coordinatorRunning:Z

    .line 167
    nop

    .end local v2    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$drain$1":I
    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 163
    monitor-exit v1

    .line 168
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    invoke-static {v1}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->access$getLanes$p(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;)Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->key:Ljava/lang/Object;

    invoke-virtual {v1, v2, p0}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 169
    return-void

    .line 163
    :catchall_0
    move-exception v2

    monitor-exit v1

    throw v2

    .line 141
    .end local v0    # "task":Lkotlin/jvm/functions/Function0;
    :catchall_1
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private final runIsolated(Lkotlin/jvm/functions/Function0;)Z
    .locals 9
    .param p1, "task"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;)Z"
        }
    .end annotation

    .line 175
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->key:Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->access$acquireWorkerCapacity(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 176
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->key:Ljava/lang/Object;

    new-instance v3, Ljava/util/concurrent/RejectedExecutionException;

    const-string/jumbo v4, "worker capacity exhausted"

    invoke-direct {v3, v4}, Ljava/util/concurrent/RejectedExecutionException;-><init>(Ljava/lang/String;)V

    check-cast v3, Ljava/lang/Throwable;

    invoke-static {v0, v2, v3}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->access$reportFailure(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 177
    return v1

    .line 179
    :cond_0
    new-instance v0, Ljava/util/concurrent/CountDownLatch;

    const/4 v2, 0x1

    invoke-direct {v0, v2}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    .line 180
    .local v0, "finished":Ljava/util/concurrent/CountDownLatch;
    new-instance v3, Ljava/lang/Thread;

    .line 192
    iget-object v4, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    new-instance v5, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane$$ExternalSyntheticLambda0;

    invoke-direct {v5, p1, v4, p0, v0}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane$$ExternalSyntheticLambda0;-><init>(Lkotlin/jvm/functions/Function0;Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;Ljava/util/concurrent/CountDownLatch;)V

    .line 191
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v6, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    invoke-static {v6}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->access$getThreadNamePrefix$p(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const/16 v6, 0x2d

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v6, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    invoke-static {v6}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->access$getThreadSequence$p(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;)Ljava/util/concurrent/atomic/AtomicLong;

    move-result-object v6

    invoke-virtual {v6}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    move-result-wide v6

    invoke-virtual {v4, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 180
    invoke-direct {v3, v5, v4}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 192
    move-object v4, v3

    .line 227
    .local v4, "$this$runIsolated_u24lambda_u247":Ljava/lang/Thread;
    const/4 v5, 0x0

    .line 192
    .local v5, "$i$a$-apply-BoundedLatestTaskDispatcher$Lane$runIsolated$worker$2":I
    invoke-virtual {v4, v2}, Ljava/lang/Thread;->setDaemon(Z)V

    .line 180
    .end local v4    # "$this$runIsolated_u24lambda_u247":Ljava/lang/Thread;
    .end local v5    # "$i$a$-apply-BoundedLatestTaskDispatcher$Lane$runIsolated$worker$2":I
    nop

    .line 193
    .local v3, "worker":Ljava/lang/Thread;
    iget-object v4, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->lock:Ljava/lang/Object;

    iget-object v5, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    monitor-enter v4

    const/4 v6, 0x0

    .line 194
    .local v6, "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$runIsolated$1":I
    :try_start_0
    iget-boolean v7, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->closed:Z

    if-eqz v7, :cond_1

    .line 195
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->key:Ljava/lang/Object;

    invoke-static {v5, v2}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->access$releaseWorkerCapacity(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_4

    .line 196
    nop

    .end local v6    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$runIsolated$1":I
    monitor-exit v4

    return v1

    .line 198
    .restart local v6    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$runIsolated$1":I
    :cond_1
    :try_start_1
    iput-object v3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->activeWorker:Ljava/lang/Thread;

    .line 199
    nop

    .end local v6    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$runIsolated$1":I
    sget-object v5, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_4

    .line 193
    monitor-exit v4

    .line 200
    nop

    .line 201
    const/4 v4, 0x0

    :try_start_2
    invoke-virtual {v3}, Ljava/lang/Thread;->start()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 210
    nop

    .line 211
    :try_start_3
    iget-object v5, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    invoke-static {v5}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->access$getTaskDeadlineMillis$p(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;)J

    move-result-wide v5

    sget-object v7, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0, v5, v6, v7}, Ljava/util/concurrent/CountDownLatch;->await(JLjava/util/concurrent/TimeUnit;)Z

    move-result v1
    :try_end_3
    .catch Ljava/lang/InterruptedException; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_0

    .line 212
    :catch_0
    move-exception v5

    .line 213
    .local v5, "_":Ljava/lang/InterruptedException;
    nop

    .line 210
    .end local v5    # "_":Ljava/lang/InterruptedException;
    :goto_0
    nop

    .line 215
    .local v1, "completed":Z
    if-nez v1, :cond_2

    .line 216
    invoke-virtual {v3}, Ljava/lang/Thread;->interrupt()V

    .line 217
    iget-object v5, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    :try_start_4
    sget-object v6, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v6, p0

    check-cast v6, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;

    .line 227
    .local v6, "$this$runIsolated_u24lambda_u2410":Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;
    const/4 v7, 0x0

    .line 217
    .local v7, "$i$a$-runCatching-BoundedLatestTaskDispatcher$Lane$runIsolated$3":I
    invoke-static {v5}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->access$getOnDeadline$p(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;)Lkotlin/jvm/functions/Function1;

    move-result-object v5

    iget-object v8, v6, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->key:Ljava/lang/Object;

    invoke-interface {v5, v8}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v5, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .end local v6    # "$this$runIsolated_u24lambda_u2410":Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;
    .end local v7    # "$i$a$-runCatching-BoundedLatestTaskDispatcher$Lane$runIsolated$3":I
    invoke-static {v5}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v5

    sget-object v6, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v5}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v5

    invoke-static {v5}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    .line 219
    :cond_2
    :goto_1
    iget-object v5, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->lock:Ljava/lang/Object;

    monitor-enter v5

    const/4 v6, 0x0

    .line 220
    .local v6, "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$runIsolated$4":I
    :try_start_5
    iget-object v7, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->activeWorker:Ljava/lang/Thread;

    if-ne v7, v3, :cond_3

    iput-object v4, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->activeWorker:Ljava/lang/Thread;

    .line 221
    :cond_3
    nop

    .end local v6    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$runIsolated$4":I
    sget-object v4, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 219
    monitor-exit v5

    .line 222
    return v2

    .line 219
    :catchall_1
    move-exception v2

    monitor-exit v5

    throw v2

    .line 202
    .end local v1    # "completed":Z
    :catchall_2
    move-exception v2

    .line 203
    .local v2, "error":Ljava/lang/Throwable;
    iget-object v5, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->lock:Ljava/lang/Object;

    monitor-enter v5

    const/4 v6, 0x0

    .line 204
    .local v6, "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$runIsolated$2":I
    :try_start_6
    iget-object v7, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->activeWorker:Ljava/lang/Thread;

    if-ne v7, v3, :cond_4

    iput-object v4, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->activeWorker:Ljava/lang/Thread;

    .line 205
    :cond_4
    nop

    .end local v6    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$runIsolated$2":I
    sget-object v4, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    .line 203
    monitor-exit v5

    .line 206
    iget-object v4, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    iget-object v5, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->key:Ljava/lang/Object;

    invoke-static {v4, v5}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->access$releaseWorkerCapacity(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Ljava/lang/Object;)Ljava/lang/Object;

    .line 207
    iget-object v4, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    iget-object v5, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->key:Ljava/lang/Object;

    invoke-static {v4, v5, v2}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->access$reportFailure(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 208
    return v1

    .line 203
    :catchall_3
    move-exception v1

    monitor-exit v5

    throw v1

    .line 193
    .end local v2    # "error":Ljava/lang/Throwable;
    :catchall_4
    move-exception v1

    monitor-exit v4

    throw v1
.end method

.method private static final runIsolated$lambda$6(Lkotlin/jvm/functions/Function0;Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;Ljava/util/concurrent/CountDownLatch;)V
    .locals 2
    .param p0, "$task"    # Lkotlin/jvm/functions/Function0;
    .param p1, "this$0"    # Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;
    .param p2, "this$1"    # Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;
    .param p3, "$finished"    # Ljava/util/concurrent/CountDownLatch;

    const-string v0, "$task"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "this$0"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "this$1"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "$finished"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 182
    nop

    .line 183
    :try_start_0
    invoke-interface {p0}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 187
    :goto_0
    iget-object v0, p2, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->key:Ljava/lang/Object;

    invoke-static {p1, v0}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->access$releaseWorkerCapacity(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Ljava/lang/Object;)Ljava/lang/Object;

    .line 188
    invoke-virtual {p3}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    .line 189
    goto :goto_1

    .line 184
    :catchall_0
    move-exception v0

    .line 185
    .local v0, "error":Ljava/lang/Throwable;
    :try_start_1
    iget-object v1, p2, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->key:Ljava/lang/Object;

    invoke-static {p1, v1, v0}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->access$reportFailure(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Ljava/lang/Object;Ljava/lang/Throwable;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .end local v0    # "error":Ljava/lang/Throwable;
    goto :goto_0

    .line 190
    :goto_1
    return-void

    .line 187
    :catchall_1
    move-exception v0

    iget-object v1, p2, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->key:Ljava/lang/Object;

    invoke-static {p1, v1}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->access$releaseWorkerCapacity(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Ljava/lang/Object;)Ljava/lang/Object;

    .line 188
    invoke-virtual {p3}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    throw v0
.end method


# virtual methods
.method public final close()V
    .locals 4

    .line 129
    const/4 v0, 0x0

    .line 130
    .local v0, "worker":Ljava/lang/Object;
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->lock:Ljava/lang/Object;

    monitor-enter v1

    const/4 v2, 0x0

    .line 131
    .local v2, "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$close$1":I
    :try_start_0
    iget-boolean v3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->closed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v3, :cond_0

    .end local v2    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$close$1":I
    monitor-exit v1

    return-void

    .line 132
    .restart local v2    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$close$1":I
    :cond_0
    const/4 v3, 0x1

    :try_start_1
    iput-boolean v3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->closed:Z

    .line 133
    const/4 v3, 0x0

    iput-object v3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->latest:Lkotlin/jvm/functions/Function0;

    .line 134
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->activeWorker:Ljava/lang/Thread;

    move-object v0, v3

    .line 135
    nop

    .end local v2    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$close$1":I
    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 130
    monitor-exit v1

    .line 136
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V

    .line 137
    :cond_1
    return-void

    .line 130
    :catchall_0
    move-exception v2

    monitor-exit v1

    throw v2
.end method

.method public final submit(Lkotlin/jvm/functions/Function0;)Z
    .locals 6
    .param p1, "task"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;)Z"
        }
    .end annotation

    const-string/jumbo v0, "task"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 112
    const/4 v0, 0x0

    .line 113
    .local v0, "startCoordinator":Z
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->lock:Ljava/lang/Object;

    monitor-enter v1

    const/4 v2, 0x0

    .line 114
    .local v2, "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$submit$1":I
    :try_start_0
    iget-boolean v3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->closed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v3, :cond_0

    .end local v2    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$submit$1":I
    monitor-exit v1

    const/4 v1, 0x0

    return v1

    .line 115
    .restart local v2    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$submit$1":I
    :cond_0
    :try_start_1
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->latest:Lkotlin/jvm/functions/Function0;

    .line 116
    iget-boolean v3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->coordinatorRunning:Z

    const/4 v4, 0x1

    xor-int/2addr v3, v4

    move v0, v3

    .line 117
    if-eqz v0, :cond_1

    iput-boolean v4, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->coordinatorRunning:Z

    .line 118
    :cond_1
    nop

    .end local v2    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$Lane$submit$1":I
    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 113
    monitor-exit v1

    .line 119
    if-eqz v0, :cond_2

    .line 120
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane$$ExternalSyntheticLambda1;

    invoke-direct {v2, p0}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane$$ExternalSyntheticLambda1;-><init>(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;)V

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v5, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    invoke-static {v5}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->access$getThreadNamePrefix$p(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, "-coordinator"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .local v1, "$this$submit_u24lambda_u241":Ljava/lang/Thread;
    const/4 v2, 0x0

    .line 121
    .local v2, "$i$a$-apply-BoundedLatestTaskDispatcher$Lane$submit$3":I
    invoke-virtual {v1, v4}, Ljava/lang/Thread;->setDaemon(Z)V

    .line 122
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    .line 123
    nop

    .line 120
    .end local v1    # "$this$submit_u24lambda_u241":Ljava/lang/Thread;
    .end local v2    # "$i$a$-apply-BoundedLatestTaskDispatcher$Lane$submit$3":I
    nop

    .line 125
    :cond_2
    return v4

    .line 113
    :catchall_0
    move-exception v2

    monitor-exit v1

    throw v2
.end method
