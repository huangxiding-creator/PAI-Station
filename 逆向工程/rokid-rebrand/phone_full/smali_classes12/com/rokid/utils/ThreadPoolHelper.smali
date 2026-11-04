.class public Lcom/rokid/utils/ThreadPoolHelper;
.super Ljava/lang/Object;
.source "ThreadPoolHelper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/utils/ThreadPoolHelper$InternalHandler;
    }
.end annotation


# static fields
.field private static final CORE_POOL_SIZE:I

.field private static final KEEP_ALIVE:I = 0x1e

.field private static final MAX_POOL_SIZE:I

.field private static final MESSAGE_RUN_ON_UITHREAD:I = 0x1

.field private static final QUEUE_CAPACITY:I = 0x100

.field private static volatile mHandler:Landroid/os/Handler;

.field private static volatile mInstance:Lcom/rokid/utils/ThreadPoolHelper;


# instance fields
.field private futureList:Ljava/util/concurrent/CopyOnWriteArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArrayList<",
            "Ljava/util/concurrent/Future<",
            "*>;>;"
        }
    .end annotation
.end field

.field private scheduledExecutorService:Ljava/util/concurrent/ScheduledExecutorService;

.field private threadPool:Ljava/util/concurrent/ThreadPoolExecutor;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 43
    const/4 v0, 0x2

    invoke-static {}, Lcom/rokid/utils/DeviceInfoUtils;->getNumberOfCPUCores()I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/rokid/utils/ThreadPoolHelper;->CORE_POOL_SIZE:I

    .line 44
    sget v0, Lcom/rokid/utils/ThreadPoolHelper;->CORE_POOL_SIZE:I

    mul-int/lit8 v0, v0, 0xa

    sput v0, Lcom/rokid/utils/ThreadPoolHelper;->MAX_POOL_SIZE:I

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 68
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 55
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    iput-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->futureList:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 69
    return-void
.end method

.method private static getHandler()Landroid/os/Handler;
    .locals 2

    .line 229
    sget-object v0, Lcom/rokid/utils/ThreadPoolHelper;->mHandler:Landroid/os/Handler;

    if-nez v0, :cond_1

    .line 230
    const-class v0, Lcom/rokid/utils/ThreadPoolHelper;

    monitor-enter v0

    .line 231
    :try_start_0
    sget-object v1, Lcom/rokid/utils/ThreadPoolHelper;->mHandler:Landroid/os/Handler;

    if-nez v1, :cond_0

    .line 232
    new-instance v1, Lcom/rokid/utils/ThreadPoolHelper$InternalHandler;

    invoke-direct {v1}, Lcom/rokid/utils/ThreadPoolHelper$InternalHandler;-><init>()V

    sput-object v1, Lcom/rokid/utils/ThreadPoolHelper;->mHandler:Landroid/os/Handler;

    .line 234
    :cond_0
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    .line 237
    :cond_1
    :goto_0
    sget-object v0, Lcom/rokid/utils/ThreadPoolHelper;->mHandler:Landroid/os/Handler;

    return-object v0
.end method

.method public static getInstance()Lcom/rokid/utils/ThreadPoolHelper;
    .locals 2

    .line 58
    sget-object v0, Lcom/rokid/utils/ThreadPoolHelper;->mInstance:Lcom/rokid/utils/ThreadPoolHelper;

    if-nez v0, :cond_1

    .line 59
    const-class v0, Lcom/rokid/utils/ThreadPoolHelper;

    monitor-enter v0

    .line 60
    :try_start_0
    sget-object v1, Lcom/rokid/utils/ThreadPoolHelper;->mInstance:Lcom/rokid/utils/ThreadPoolHelper;

    if-nez v1, :cond_0

    .line 61
    new-instance v1, Lcom/rokid/utils/ThreadPoolHelper;

    invoke-direct {v1}, Lcom/rokid/utils/ThreadPoolHelper;-><init>()V

    sput-object v1, Lcom/rokid/utils/ThreadPoolHelper;->mInstance:Lcom/rokid/utils/ThreadPoolHelper;

    .line 63
    :cond_0
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    .line 65
    :cond_1
    :goto_0
    sget-object v0, Lcom/rokid/utils/ThreadPoolHelper;->mInstance:Lcom/rokid/utils/ThreadPoolHelper;

    return-object v0
.end method

.method private initScheduledExecutor()V
    .locals 3

    .line 263
    new-instance v0, Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    sget v1, Lcom/rokid/utils/ThreadPoolHelper;->CORE_POOL_SIZE:I

    new-instance v2, Lcom/rokid/utils/ThreadPoolHelper$2;

    invoke-direct {v2, p0}, Lcom/rokid/utils/ThreadPoolHelper$2;-><init>(Lcom/rokid/utils/ThreadPoolHelper;)V

    invoke-direct {v0, v1, v2}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;-><init>(ILjava/util/concurrent/ThreadFactory;)V

    iput-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->scheduledExecutorService:Ljava/util/concurrent/ScheduledExecutorService;

    .line 275
    return-void
.end method

.method private initThreadPool()V
    .locals 9

    .line 139
    new-instance v8, Ljava/util/concurrent/ThreadPoolExecutor;

    sget v1, Lcom/rokid/utils/ThreadPoolHelper;->CORE_POOL_SIZE:I

    sget v2, Lcom/rokid/utils/ThreadPoolHelper;->MAX_POOL_SIZE:I

    sget-object v5, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v6, Ljava/util/concurrent/LinkedBlockingQueue;

    const/16 v0, 0x100

    invoke-direct {v6, v0}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>(I)V

    new-instance v7, Lcom/rokid/utils/ThreadPoolHelper$1;

    invoke-direct {v7, p0}, Lcom/rokid/utils/ThreadPoolHelper$1;-><init>(Lcom/rokid/utils/ThreadPoolHelper;)V

    const-wide/16 v3, 0x1e

    move-object v0, v8

    invoke-direct/range {v0 .. v7}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;Ljava/util/concurrent/ThreadFactory;)V

    iput-object v8, p0, Lcom/rokid/utils/ThreadPoolHelper;->threadPool:Ljava/util/concurrent/ThreadPoolExecutor;

    .line 150
    return-void
.end method

.method public static runOnUiThread(Ljava/lang/Runnable;)V
    .locals 1
    .param p0, "command"    # Ljava/lang/Runnable;

    .line 95
    invoke-static {}, Lcom/rokid/utils/ThreadPoolHelper;->getHandler()Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 96
    return-void
.end method

.method public static runOnUiThread(Ljava/lang/Runnable;J)V
    .locals 1
    .param p0, "command"    # Ljava/lang/Runnable;
    .param p1, "delayMillis"    # J

    .line 99
    invoke-static {}, Lcom/rokid/utils/ThreadPoolHelper;->getHandler()Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p0, p1, p2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 100
    return-void
.end method

.method public static runOnUiThread(Ljava/lang/Runnable;Z)V
    .locals 4
    .param p0, "runnable"    # Ljava/lang/Runnable;
    .param p1, "waitUtilDone"    # Z

    .line 72
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-virtual {v1}, Landroid/os/Looper;->getThread()Ljava/lang/Thread;

    move-result-object v1

    if-ne v0, v1, :cond_0

    .line 73
    invoke-interface {p0}, Ljava/lang/Runnable;->run()V

    .line 74
    return-void

    .line 77
    :cond_0
    const/4 v0, 0x0

    .line 78
    .local v0, "countDownLatch":Ljava/util/concurrent/CountDownLatch;
    const/4 v1, 0x1

    if-eqz p1, :cond_1

    .line 79
    new-instance v2, Ljava/util/concurrent/CountDownLatch;

    invoke-direct {v2, v1}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    move-object v0, v2

    .line 82
    :cond_1
    new-instance v2, Landroid/util/Pair;

    invoke-direct {v2, p0, v0}, Landroid/util/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 83
    .local v2, "pair":Landroid/util/Pair;, "Landroid/util/Pair<Ljava/lang/Runnable;Ljava/util/concurrent/CountDownLatch;>;"
    invoke-static {}, Lcom/rokid/utils/ThreadPoolHelper;->getHandler()Landroid/os/Handler;

    move-result-object v3

    invoke-virtual {v3, v1, v2}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v1

    .line 84
    invoke-virtual {v1}, Landroid/os/Message;->sendToTarget()V

    .line 86
    if-eqz p1, :cond_2

    .line 88
    :try_start_0
    invoke-virtual {v0}, Ljava/util/concurrent/CountDownLatch;->await()V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 90
    goto :goto_0

    .line 89
    :catch_0
    move-exception v1

    .line 92
    :cond_2
    :goto_0
    return-void
.end method


# virtual methods
.method public shutDownScheduledTask()V
    .locals 3

    .line 209
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->scheduledExecutorService:Ljava/util/concurrent/ScheduledExecutorService;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->scheduledExecutorService:Ljava/util/concurrent/ScheduledExecutorService;

    invoke-interface {v0}, Ljava/util/concurrent/ScheduledExecutorService;->isShutdown()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_1

    .line 213
    :cond_0
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->futureList:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-static {v0}, Lcom/rokid/utils/CollectionUtils;->isEmpty(Ljava/util/Collection;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 214
    return-void

    .line 217
    :cond_1
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->futureList:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/concurrent/Future;

    .line 218
    .local v1, "future":Ljava/util/concurrent/Future;
    if-eqz v1, :cond_2

    .line 219
    const/4 v2, 0x1

    invoke-interface {v1, v2}, Ljava/util/concurrent/Future;->cancel(Z)Z

    .line 221
    .end local v1    # "future":Ljava/util/concurrent/Future;
    :cond_2
    goto :goto_0

    .line 222
    :cond_3
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->futureList:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V

    .line 224
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->scheduledExecutorService:Ljava/util/concurrent/ScheduledExecutorService;

    invoke-interface {v0}, Ljava/util/concurrent/ScheduledExecutorService;->shutdownNow()Ljava/util/List;

    .line 225
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->scheduledExecutorService:Ljava/util/concurrent/ScheduledExecutorService;

    .line 226
    return-void

    .line 210
    :cond_4
    :goto_1
    return-void
.end method

.method public shutDownScheduledTask(Ljava/util/concurrent/Future;)V
    .locals 1
    .param p1, "future"    # Ljava/util/concurrent/Future;

    .line 192
    if-nez p1, :cond_0

    .line 193
    return-void

    .line 196
    :cond_0
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->scheduledExecutorService:Ljava/util/concurrent/ScheduledExecutorService;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->scheduledExecutorService:Ljava/util/concurrent/ScheduledExecutorService;

    invoke-interface {v0}, Ljava/util/concurrent/ScheduledExecutorService;->isShutdown()Z

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    .line 200
    :cond_1
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->futureList:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-static {v0}, Lcom/rokid/utils/CollectionUtils;->isEmpty(Ljava/util/Collection;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 201
    return-void

    .line 204
    :cond_2
    const/4 v0, 0x1

    invoke-interface {p1, v0}, Ljava/util/concurrent/Future;->cancel(Z)Z

    .line 205
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->futureList:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->remove(Ljava/lang/Object;)Z

    .line 206
    return-void

    .line 197
    :cond_3
    :goto_0
    return-void
.end method

.method public shutDownTask()V
    .locals 1

    .line 153
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->threadPool:Ljava/util/concurrent/ThreadPoolExecutor;

    if-eqz v0, :cond_0

    .line 154
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->threadPool:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v0}, Ljava/util/concurrent/ThreadPoolExecutor;->shutdownNow()Ljava/util/List;

    .line 155
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->threadPool:Ljava/util/concurrent/ThreadPoolExecutor;

    .line 157
    :cond_0
    return-void
.end method

.method public startScheduleTask(Ljava/lang/Runnable;J)Ljava/util/concurrent/Future;
    .locals 1
    .param p1, "runnable"    # Ljava/lang/Runnable;
    .param p2, "delay"    # J

    .line 164
    sget-object v0, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/rokid/utils/ThreadPoolHelper;->startScheduleTask(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/Future;

    move-result-object v0

    return-object v0
.end method

.method public startScheduleTask(Ljava/lang/Runnable;JJ)Ljava/util/concurrent/Future;
    .locals 7
    .param p1, "runnable"    # Ljava/lang/Runnable;
    .param p2, "delay"    # J
    .param p4, "period"    # J

    .line 160
    sget-object v6, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    move-object v0, p0

    move-object v1, p1

    move-wide v2, p2

    move-wide v4, p4

    invoke-virtual/range {v0 .. v6}, Lcom/rokid/utils/ThreadPoolHelper;->startScheduleTask(Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/Future;

    move-result-object v0

    return-object v0
.end method

.method public startScheduleTask(Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/Future;
    .locals 8
    .param p1, "runnable"    # Ljava/lang/Runnable;
    .param p2, "delay"    # J
    .param p4, "period"    # J
    .param p6, "unit"    # Ljava/util/concurrent/TimeUnit;

    .line 176
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->scheduledExecutorService:Ljava/util/concurrent/ScheduledExecutorService;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->scheduledExecutorService:Ljava/util/concurrent/ScheduledExecutorService;

    invoke-interface {v0}, Ljava/util/concurrent/ScheduledExecutorService;->isShutdown()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 177
    :cond_0
    invoke-direct {p0}, Lcom/rokid/utils/ThreadPoolHelper;->initScheduledExecutor()V

    .line 181
    :cond_1
    const-wide/16 v0, 0x0

    cmp-long v0, p4, v0

    if-lez v0, :cond_2

    .line 182
    iget-object v1, p0, Lcom/rokid/utils/ThreadPoolHelper;->scheduledExecutorService:Ljava/util/concurrent/ScheduledExecutorService;

    move-object v2, p1

    move-wide v3, p2

    move-wide v5, p4

    move-object v7, p6

    invoke-interface/range {v1 .. v7}, Ljava/util/concurrent/ScheduledExecutorService;->scheduleAtFixedRate(Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object v0

    .local v0, "future":Ljava/util/concurrent/Future;
    goto :goto_0

    .line 184
    .end local v0    # "future":Ljava/util/concurrent/Future;
    :cond_2
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->scheduledExecutorService:Ljava/util/concurrent/ScheduledExecutorService;

    invoke-interface {v0, p1, p2, p3, p6}, Ljava/util/concurrent/ScheduledExecutorService;->schedule(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object v0

    .line 187
    .restart local v0    # "future":Ljava/util/concurrent/Future;
    :goto_0
    iget-object v1, p0, Lcom/rokid/utils/ThreadPoolHelper;->futureList:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v1, v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    .line 188
    return-object v0
.end method

.method public startScheduleTask(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/Future;
    .locals 7
    .param p1, "runnable"    # Ljava/lang/Runnable;
    .param p2, "delay"    # J
    .param p4, "unit"    # Ljava/util/concurrent/TimeUnit;

    .line 168
    const-wide/16 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move-wide v2, p2

    move-object v6, p4

    invoke-virtual/range {v0 .. v6}, Lcom/rokid/utils/ThreadPoolHelper;->startScheduleTask(Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/Future;

    move-result-object v0

    return-object v0
.end method

.method public threadExecute(Ljava/lang/Runnable;)V
    .locals 1
    .param p1, "command"    # Ljava/lang/Runnable;

    .line 103
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->threadPool:Ljava/util/concurrent/ThreadPoolExecutor;

    if-nez v0, :cond_0

    .line 104
    invoke-direct {p0}, Lcom/rokid/utils/ThreadPoolHelper;->initThreadPool()V

    .line 107
    :cond_0
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->threadPool:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    .line 108
    return-void
.end method

.method public threadSubmit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;
    .locals 1
    .param p1, "command"    # Ljava/lang/Runnable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Runnable;",
            ")",
            "Ljava/util/concurrent/Future<",
            "*>;"
        }
    .end annotation

    .line 111
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->threadPool:Ljava/util/concurrent/ThreadPoolExecutor;

    if-nez v0, :cond_0

    .line 112
    invoke-direct {p0}, Lcom/rokid/utils/ThreadPoolHelper;->initThreadPool()V

    .line 115
    :cond_0
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->threadPool:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ThreadPoolExecutor;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    move-result-object v0

    return-object v0
.end method

.method public threadSubmit(Ljava/lang/Runnable;Ljava/lang/Object;)Ljava/util/concurrent/Future;
    .locals 1
    .param p1, "task"    # Ljava/lang/Runnable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Runnable;",
            "TT;)",
            "Ljava/util/concurrent/Future<",
            "TT;>;"
        }
    .end annotation

    .line 127
    .local p2, "result":Ljava/lang/Object;, "TT;"
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->threadPool:Ljava/util/concurrent/ThreadPoolExecutor;

    if-nez v0, :cond_0

    .line 128
    invoke-direct {p0}, Lcom/rokid/utils/ThreadPoolHelper;->initThreadPool()V

    .line 131
    :cond_0
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->threadPool:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v0, p1, p2}, Ljava/util/concurrent/ThreadPoolExecutor;->submit(Ljava/lang/Runnable;Ljava/lang/Object;)Ljava/util/concurrent/Future;

    move-result-object v0

    return-object v0
.end method

.method public threadSubmit(Ljava/util/concurrent/Callable;)Ljava/util/concurrent/Future;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/util/concurrent/Callable<",
            "TT;>;)",
            "Ljava/util/concurrent/Future<",
            "TT;>;"
        }
    .end annotation

    .line 119
    .local p1, "task":Ljava/util/concurrent/Callable;, "Ljava/util/concurrent/Callable<TT;>;"
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->threadPool:Ljava/util/concurrent/ThreadPoolExecutor;

    if-nez v0, :cond_0

    .line 120
    invoke-direct {p0}, Lcom/rokid/utils/ThreadPoolHelper;->initThreadPool()V

    .line 123
    :cond_0
    iget-object v0, p0, Lcom/rokid/utils/ThreadPoolHelper;->threadPool:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ThreadPoolExecutor;->submit(Ljava/util/concurrent/Callable;)Ljava/util/concurrent/Future;

    move-result-object v0

    return-object v0
.end method
