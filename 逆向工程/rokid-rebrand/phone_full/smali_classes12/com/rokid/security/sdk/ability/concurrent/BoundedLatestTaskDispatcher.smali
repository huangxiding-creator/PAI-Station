.class public final Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;
.super Ljava/lang/Object;
.source "BoundedLatestTaskDispatcher.kt"

# interfaces
.implements Ljava/lang/AutoCloseable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<K:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;",
        "Ljava/lang/AutoCloseable;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBoundedLatestTaskDispatcher.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BoundedLatestTaskDispatcher.kt\ncom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,226:1\n1#2:227\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000j\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u0003\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010%\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0012\u0018\u0000*\u0004\u0008\u0000\u0010\u00012\u00020\u0002:\u00016Ba\u0008\u0007\u0012\u0008\u0008\u0002\u0010\u0003\u001a\u00020\u0004\u0012\u0008\u0008\u0002\u0010\u0005\u001a\u00020\u0006\u0012\u0008\u0008\u0002\u0010\u0007\u001a\u00020\u0008\u0012\u0008\u0008\u0002\u0010\t\u001a\u00020\u0008\u0012\u0014\u0008\u0002\u0010\n\u001a\u000e\u0012\u0004\u0012\u00028\u0000\u0012\u0004\u0012\u00020\u000c0\u000b\u0012\u001a\u0008\u0002\u0010\r\u001a\u0014\u0012\u0004\u0012\u00028\u0000\u0012\u0004\u0012\u00020\u000f\u0012\u0004\u0012\u00020\u000c0\u000e\u00a2\u0006\u0002\u0010\u0010J\u0015\u0010\u001e\u001a\u00020\u001f2\u0006\u0010 \u001a\u00028\u0000H\u0002\u00a2\u0006\u0002\u0010!J\u0008\u0010\"\u001a\u00020\u000cH\u0016J!\u0010#\u001a\u00020\u001f2\u0006\u0010 \u001a\u00028\u00002\u000c\u0010$\u001a\u0008\u0012\u0004\u0012\u00020\u000c0%\u00a2\u0006\u0002\u0010&J\u0015\u0010\'\u001a\u00020\u001f2\u0006\u0010 \u001a\u00028\u0000H\u0002\u00a2\u0006\u0002\u0010!J\r\u0010(\u001a\u00020\u0008H\u0000\u00a2\u0006\u0002\u0008)J\u0017\u0010*\u001a\u0004\u0018\u00010\u00172\u0006\u0010 \u001a\u00028\u0000H\u0002\u00a2\u0006\u0002\u0010+J\u0013\u0010,\u001a\u00020\u000c2\u0006\u0010 \u001a\u00028\u0000\u00a2\u0006\u0002\u0010-J\u001d\u0010.\u001a\u00020\u000c2\u0006\u0010 \u001a\u00028\u00002\u0006\u0010/\u001a\u00020\u000fH\u0002\u00a2\u0006\u0002\u00100J\u0017\u00101\u001a\u00020\u00082\u0006\u0010 \u001a\u00028\u0000H\u0000\u00a2\u0006\u0004\u00082\u00103J\r\u00104\u001a\u00020\u0008H\u0000\u00a2\u0006\u0002\u00085R\u000e\u0010\u0011\u001a\u00020\u0012X\u0082\u0004\u00a2\u0006\u0002\n\u0000R$\u0010\u0013\u001a\u0018\u0012\u0004\u0012\u00028\u0000\u0012\u000e\u0012\u000c0\u0015R\u0008\u0012\u0004\u0012\u00028\u00000\u00000\u0014X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0016\u001a\u00020\u0017X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0008X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010\n\u001a\u000e\u0012\u0004\u0012\u00028\u0000\u0012\u0004\u0012\u00020\u000c0\u000bX\u0082\u0004\u00a2\u0006\u0002\n\u0000R \u0010\r\u001a\u0014\u0012\u0004\u0012\u00028\u0000\u0012\u0004\u0012\u00020\u000f\u0012\u0004\u0012\u00020\u000c0\u000eX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0018\u001a\u00020\u0019X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001a\u001a\u00020\u0017X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001b\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u001c\u001a\u000e\u0012\u0004\u0012\u00028\u0000\u0012\u0004\u0012\u00020\u00080\u001dX\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u00067"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;",
        "K",
        "Ljava/lang/AutoCloseable;",
        "taskDeadlineMillis",
        "",
        "threadNamePrefix",
        "",
        "maxWorkerThreads",
        "",
        "maxWorkersPerKey",
        "onDeadline",
        "Lkotlin/Function1;",
        "",
        "onFailure",
        "Lkotlin/Function2;",
        "",
        "(JLjava/lang/String;IILkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;)V",
        "closed",
        "Ljava/util/concurrent/atomic/AtomicBoolean;",
        "lanes",
        "Ljava/util/concurrent/ConcurrentHashMap;",
        "Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;",
        "lifecycleLock",
        "",
        "threadSequence",
        "Ljava/util/concurrent/atomic/AtomicLong;",
        "workerCapacityLock",
        "workerCount",
        "workersPerKey",
        "",
        "acquireWorkerCapacity",
        "",
        "key",
        "(Ljava/lang/Object;)Z",
        "close",
        "dispatch",
        "task",
        "Lkotlin/Function0;",
        "(Ljava/lang/Object;Lkotlin/jvm/functions/Function0;)Z",
        "hasWorkerCapacity",
        "laneCountForTest",
        "laneCountForTest$sdk_common_ability_release",
        "releaseWorkerCapacity",
        "(Ljava/lang/Object;)Ljava/lang/Object;",
        "remove",
        "(Ljava/lang/Object;)V",
        "reportFailure",
        "error",
        "(Ljava/lang/Object;Ljava/lang/Throwable;)V",
        "workerCountForKeyForTest",
        "workerCountForKeyForTest$sdk_common_ability_release",
        "(Ljava/lang/Object;)I",
        "workerCountForTest",
        "workerCountForTest$sdk_common_ability_release",
        "Lane",
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
.field private final closed:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private final lanes:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "TK;",
            "Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher<",
            "TK;>.",
            "Lane;",
            ">;"
        }
    .end annotation
.end field

.field private final lifecycleLock:Ljava/lang/Object;

.field private final maxWorkerThreads:I

.field private final maxWorkersPerKey:I

.field private final onDeadline:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "TK;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field private final onFailure:Lkotlin/jvm/functions/Function2;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function2<",
            "TK;",
            "Ljava/lang/Throwable;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field private final taskDeadlineMillis:J

.field private final threadNamePrefix:Ljava/lang/String;

.field private final threadSequence:Ljava/util/concurrent/atomic/AtomicLong;

.field private final workerCapacityLock:Ljava/lang/Object;

.field private workerCount:I

.field private final workersPerKey:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "TK;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public static synthetic $r8$lambda$OLZ-XWEXtNkGyu6zxq1uILrZ_4U(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;)Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->dispatch$lambda$1$lambda$0(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;)Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$vXKinjxYU-TsVx4uqjr0z8XCRUI(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->close$lambda$3$lambda$2(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 10

    const/16 v8, 0x3f

    const/4 v9, 0x0

    const-wide/16 v1, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v0, p0

    invoke-direct/range {v0 .. v9}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;-><init>(JLjava/lang/String;IILkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-void
.end method

.method public constructor <init>(J)V
    .locals 10

    const/16 v8, 0x3e

    const/4 v9, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v0, p0

    move-wide v1, p1

    invoke-direct/range {v0 .. v9}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;-><init>(JLjava/lang/String;IILkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-void
.end method

.method public constructor <init>(JLjava/lang/String;)V
    .locals 11

    const-string/jumbo v0, "threadNamePrefix"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v9, 0x3c

    const/4 v10, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v1, p0

    move-wide v2, p1

    move-object v4, p3

    invoke-direct/range {v1 .. v10}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;-><init>(JLjava/lang/String;IILkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-void
.end method

.method public constructor <init>(JLjava/lang/String;I)V
    .locals 11

    const-string/jumbo v0, "threadNamePrefix"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v9, 0x38

    const/4 v10, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v1, p0

    move-wide v2, p1

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v1 .. v10}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;-><init>(JLjava/lang/String;IILkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-void
.end method

.method public constructor <init>(JLjava/lang/String;II)V
    .locals 12

    const-string/jumbo v0, "threadNamePrefix"

    move-object v11, p3

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v9, 0x30

    const/4 v10, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v1, p0

    move-wide v2, p1

    move-object v4, p3

    move/from16 v5, p4

    move/from16 v6, p5

    invoke-direct/range {v1 .. v10}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;-><init>(JLjava/lang/String;IILkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-void
.end method

.method public constructor <init>(JLjava/lang/String;IILkotlin/jvm/functions/Function1;)V
    .locals 13
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Ljava/lang/String;",
            "II",
            "Lkotlin/jvm/functions/Function1<",
            "-TK;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string/jumbo v0, "threadNamePrefix"

    move-object/from16 v11, p3

    invoke-static {v11, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onDeadline"

    move-object/from16 v12, p6

    invoke-static {v12, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v9, 0x20

    const/4 v10, 0x0

    const/4 v8, 0x0

    move-object v1, p0

    move-wide v2, p1

    move-object/from16 v4, p3

    move/from16 v5, p4

    move/from16 v6, p5

    move-object/from16 v7, p6

    invoke-direct/range {v1 .. v10}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;-><init>(JLjava/lang/String;IILkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-void
.end method

.method public constructor <init>(JLjava/lang/String;IILkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;)V
    .locals 6
    .param p1, "taskDeadlineMillis"    # J
    .param p3, "threadNamePrefix"    # Ljava/lang/String;
    .param p4, "maxWorkerThreads"    # I
    .param p5, "maxWorkersPerKey"    # I
    .param p6, "onDeadline"    # Lkotlin/jvm/functions/Function1;
    .param p7, "onFailure"    # Lkotlin/jvm/functions/Function2;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Ljava/lang/String;",
            "II",
            "Lkotlin/jvm/functions/Function1<",
            "-TK;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/jvm/functions/Function2<",
            "-TK;-",
            "Ljava/lang/Throwable;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string/jumbo v0, "threadNamePrefix"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onDeadline"

    invoke-static {p6, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onFailure"

    invoke-static {p7, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    iput-wide p1, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->taskDeadlineMillis:J

    .line 20
    iput-object p3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->threadNamePrefix:Ljava/lang/String;

    .line 21
    iput p4, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->maxWorkerThreads:I

    .line 22
    iput p5, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->maxWorkersPerKey:I

    .line 23
    iput-object p6, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->onDeadline:Lkotlin/jvm/functions/Function1;

    .line 24
    iput-object p7, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->onFailure:Lkotlin/jvm/functions/Function2;

    .line 26
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->lanes:Ljava/util/concurrent/ConcurrentHashMap;

    .line 27
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->closed:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 28
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->lifecycleLock:Ljava/lang/Object;

    .line 29
    new-instance v0, Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v2, 0x0

    invoke-direct {v0, v2, v3}, Ljava/util/concurrent/atomic/AtomicLong;-><init>(J)V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->threadSequence:Ljava/util/concurrent/atomic/AtomicLong;

    .line 30
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workerCapacityLock:Ljava/lang/Object;

    .line 31
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v0, Ljava/util/Map;

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workersPerKey:Ljava/util/Map;

    .line 34
    nop

    .line 35
    iget-wide v4, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->taskDeadlineMillis:J

    cmp-long v0, v4, v2

    const/4 v2, 0x1

    if-lez v0, :cond_0

    move v0, v2

    goto :goto_0

    :cond_0
    move v0, v1

    :goto_0
    const-string v3, "Failed requirement."

    if-eqz v0, :cond_7

    .line 36
    iget v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->maxWorkerThreads:I

    if-lez v0, :cond_1

    move v0, v2

    goto :goto_1

    :cond_1
    move v0, v1

    :goto_1
    if-eqz v0, :cond_6

    .line 37
    iget v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->maxWorkersPerKey:I

    if-lez v0, :cond_2

    move v0, v2

    goto :goto_2

    :cond_2
    move v0, v1

    :goto_2
    if-eqz v0, :cond_5

    .line 38
    iget v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->maxWorkersPerKey:I

    iget v4, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->maxWorkerThreads:I

    if-gt v0, v4, :cond_3

    move v1, v2

    :cond_3
    if-eqz v1, :cond_4

    .line 39
    nop

    .line 18
    return-void

    .line 38
    :cond_4
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 37
    :cond_5
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 36
    :cond_6
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 35
    :cond_7
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public synthetic constructor <init>(JLjava/lang/String;IILkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;ILkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 7

    .line 18
    and-int/lit8 v0, p8, 0x1

    if-eqz v0, :cond_0

    .line 19
    const-wide/16 v0, 0x7d0

    goto :goto_0

    .line 18
    :cond_0
    move-wide v0, p1

    :goto_0
    and-int/lit8 v2, p8, 0x2

    if-eqz v2, :cond_1

    .line 20
    const-string v2, "latest-task"

    goto :goto_1

    .line 18
    :cond_1
    move-object v2, p3

    :goto_1
    and-int/lit8 v3, p8, 0x4

    if-eqz v3, :cond_2

    .line 21
    const/16 v3, 0x8

    goto :goto_2

    .line 18
    :cond_2
    move v3, p4

    :goto_2
    and-int/lit8 v4, p8, 0x8

    if-eqz v4, :cond_3

    .line 22
    const/4 v4, 0x2

    goto :goto_3

    .line 18
    :cond_3
    move v4, p5

    :goto_3
    and-int/lit8 v5, p8, 0x10

    if-eqz v5, :cond_4

    .line 23
    sget-object v5, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$1;->INSTANCE:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$1;

    check-cast v5, Lkotlin/jvm/functions/Function1;

    goto :goto_4

    .line 18
    :cond_4
    move-object v5, p6

    :goto_4
    and-int/lit8 v6, p8, 0x20

    if-eqz v6, :cond_5

    .line 24
    sget-object v6, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$2;->INSTANCE:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$2;

    check-cast v6, Lkotlin/jvm/functions/Function2;

    goto :goto_5

    .line 18
    :cond_5
    move-object v6, p7

    :goto_5
    move-object p1, p0

    move-wide p2, v0

    move-object p4, v2

    move p5, v3

    move p6, v4

    move-object p7, v5

    move-object p8, v6

    invoke-direct/range {p1 .. p8}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;-><init>(JLjava/lang/String;IILkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;)V

    .line 225
    return-void
.end method

.method public static final synthetic access$acquireWorkerCapacity(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Ljava/lang/Object;)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;
    .param p1, "key"    # Ljava/lang/Object;

    .line 18
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->acquireWorkerCapacity(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static final synthetic access$getLanes$p(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;)Ljava/util/concurrent/ConcurrentHashMap;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    .line 18
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->lanes:Ljava/util/concurrent/ConcurrentHashMap;

    return-object v0
.end method

.method public static final synthetic access$getOnDeadline$p(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;)Lkotlin/jvm/functions/Function1;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    .line 18
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->onDeadline:Lkotlin/jvm/functions/Function1;

    return-object v0
.end method

.method public static final synthetic access$getTaskDeadlineMillis$p(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;)J
    .locals 2
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    .line 18
    iget-wide v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->taskDeadlineMillis:J

    return-wide v0
.end method

.method public static final synthetic access$getThreadNamePrefix$p(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    .line 18
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->threadNamePrefix:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getThreadSequence$p(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;)Ljava/util/concurrent/atomic/AtomicLong;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    .line 18
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->threadSequence:Ljava/util/concurrent/atomic/AtomicLong;

    return-object v0
.end method

.method public static final synthetic access$releaseWorkerCapacity(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;
    .param p1, "key"    # Ljava/lang/Object;

    .line 18
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->releaseWorkerCapacity(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$reportFailure(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Ljava/lang/Object;Ljava/lang/Throwable;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;
    .param p1, "key"    # Ljava/lang/Object;
    .param p2, "error"    # Ljava/lang/Throwable;

    .line 18
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->reportFailure(Ljava/lang/Object;Ljava/lang/Throwable;)V

    return-void
.end method

.method private final acquireWorkerCapacity(Ljava/lang/Object;)Z
    .locals 6
    .param p1, "key"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;)Z"
        }
    .end annotation

    .line 84
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workerCapacityLock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    .line 85
    .local v1, "$i$a$-synchronized-BoundedLatestTaskDispatcher$acquireWorkerCapacity$1":I
    :try_start_0
    iget v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workerCount:I

    iget v3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->maxWorkerThreads:I

    const/4 v4, 0x0

    if-ge v2, v3, :cond_3

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workersPerKey:Ljava/util/Map;

    invoke-interface {v2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    goto :goto_0

    :cond_0
    move v2, v4

    :goto_0
    iget v3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->maxWorkersPerKey:I

    if-lt v2, v3, :cond_1

    goto :goto_1

    .line 88
    :cond_1
    iget v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workerCount:I

    const/4 v3, 0x1

    add-int/2addr v2, v3

    iput v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workerCount:I

    .line 89
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workersPerKey:Ljava/util/Map;

    iget-object v5, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workersPerKey:Ljava/util/Map;

    invoke-interface {v5, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Integer;

    if-eqz v5, :cond_2

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v4

    :cond_2
    add-int/2addr v4, v3

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v2, p1, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 90
    move v4, v3

    goto :goto_2

    .line 86
    :cond_3
    :goto_1
    nop

    .line 85
    :goto_2
    nop

    .line 84
    .end local v1    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$acquireWorkerCapacity$1":I
    monitor-exit v0

    .line 92
    return v4

    .line 84
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private static final close$lambda$3$lambda$2(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 1
    .param p0, "$tmp0"    # Lkotlin/jvm/functions/Function2;
    .param p1, "p0"    # Ljava/lang/Object;
    .param p2, "p1"    # Ljava/lang/Object;

    const-string v0, "$tmp0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 70
    invoke-interface {p0, p1, p2}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private static final dispatch$lambda$1$lambda$0(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;)Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;
    .locals 1
    .param p0, "$tmp0"    # Lkotlin/jvm/functions/Function1;
    .param p1, "p0"    # Ljava/lang/Object;

    const-string v0, "$tmp0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 53
    invoke-interface {p0, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;

    return-object v0
.end method

.method private final hasWorkerCapacity(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "key"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;)Z"
        }
    .end annotation

    .line 80
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workerCapacityLock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    .line 81
    .local v1, "$i$a$-synchronized-BoundedLatestTaskDispatcher$hasWorkerCapacity$1":I
    :try_start_0
    iget v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workerCount:I

    iget v3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->maxWorkerThreads:I

    const/4 v4, 0x0

    if-ge v2, v3, :cond_1

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workersPerKey:Ljava/util/Map;

    invoke-interface {v2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    goto :goto_0

    :cond_0
    move v2, v4

    :goto_0
    iget v3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->maxWorkersPerKey:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-ge v2, v3, :cond_1

    const/4 v4, 0x1

    .line 80
    .end local v1    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$hasWorkerCapacity$1":I
    :cond_1
    monitor-exit v0

    .line 82
    return v4

    .line 80
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private final releaseWorkerCapacity(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 5
    .param p1, "key"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 94
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workerCapacityLock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    .line 95
    .local v1, "$i$a$-synchronized-BoundedLatestTaskDispatcher$releaseWorkerCapacity$1":I
    :try_start_0
    iget v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workerCount:I

    add-int/lit8 v2, v2, -0x1

    iput v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workerCount:I

    .line 96
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workersPerKey:Ljava/util/Map;

    invoke-interface {v2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    const/4 v3, 0x1

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    goto :goto_0

    :cond_0
    move v2, v3

    :goto_0
    sub-int/2addr v2, v3

    .line 97
    .local v2, "remaining":I
    if-nez v2, :cond_1

    iget-object v3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workersPerKey:Ljava/util/Map;

    invoke-interface {v3, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    goto :goto_1

    :cond_1
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    iget-object v4, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workersPerKey:Ljava/util/Map;

    invoke-interface {v4, p1, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 94
    .end local v1    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$releaseWorkerCapacity$1":I
    .end local v2    # "remaining":I
    :goto_1
    monitor-exit v0

    .line 98
    return-object v3

    .line 94
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private final reportFailure(Ljava/lang/Object;Ljava/lang/Throwable;)V
    .locals 3
    .param p1, "key"    # Ljava/lang/Object;
    .param p2, "error"    # Ljava/lang/Throwable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;",
            "Ljava/lang/Throwable;",
            ")V"
        }
    .end annotation

    .line 101
    :try_start_0
    sget-object v0, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v0, p0

    check-cast v0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    .line 227
    .local v0, "$this$reportFailure_u24lambda_u249":Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;
    const/4 v1, 0x0

    .line 101
    .local v1, "$i$a$-runCatching-BoundedLatestTaskDispatcher$reportFailure$1":I
    iget-object v2, v0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->onFailure:Lkotlin/jvm/functions/Function2;

    invoke-interface {v2, p1, p2}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .end local v0    # "$this$reportFailure_u24lambda_u249":Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;
    .end local v1    # "$i$a$-runCatching-BoundedLatestTaskDispatcher$reportFailure$1":I
    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v0}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    .line 102
    :goto_0
    return-void
.end method


# virtual methods
.method public close()V
    .locals 5

    .line 65
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->lifecycleLock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    .line 66
    .local v1, "$i$a$-synchronized-BoundedLatestTaskDispatcher$close$1":I
    :try_start_0
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->closed:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v3, 0x0

    const/4 v4, 0x1

    invoke-virtual {v2, v3, v4}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v2, :cond_0

    .end local v1    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$close$1":I
    monitor-exit v0

    return-void

    .line 70
    .restart local v1    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$close$1":I
    :cond_0
    :try_start_1
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->lanes:Ljava/util/concurrent/ConcurrentHashMap;

    sget-object v3, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$close$1$1;->INSTANCE:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$close$1$1;

    check-cast v3, Lkotlin/jvm/functions/Function2;

    new-instance v4, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$$ExternalSyntheticLambda0;

    invoke-direct {v4, v3}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$$ExternalSyntheticLambda0;-><init>(Lkotlin/jvm/functions/Function2;)V

    invoke-virtual {v2, v4}, Ljava/util/concurrent/ConcurrentHashMap;->forEach(Ljava/util/function/BiConsumer;)V

    .line 71
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->lanes:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v2}, Ljava/util/concurrent/ConcurrentHashMap;->clear()V

    .line 72
    nop

    .end local v1    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$close$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 65
    monitor-exit v0

    .line 73
    return-void

    .line 65
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public final dispatch(Ljava/lang/Object;Lkotlin/jvm/functions/Function0;)Z
    .locals 5
    .param p1, "key"    # Ljava/lang/Object;
    .param p2, "task"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;)Z"
        }
    .end annotation

    const-string/jumbo v0, "task"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    :goto_0
    nop

    .line 43
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->closed:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    .line 44
    :cond_0
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->hasWorkerCapacity(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 45
    new-instance v0, Ljava/util/concurrent/RejectedExecutionException;

    const-string/jumbo v2, "worker capacity exhausted"

    invoke-direct {v0, v2}, Ljava/util/concurrent/RejectedExecutionException;-><init>(Ljava/lang/String;)V

    check-cast v0, Ljava/lang/Throwable;

    invoke-direct {p0, p1, v0}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->reportFailure(Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 46
    return v1

    .line 48
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->lifecycleLock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v2, 0x0

    .line 52
    .local v2, "$i$a$-synchronized-BoundedLatestTaskDispatcher$dispatch$lane$1":I
    :try_start_0
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->closed:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v3}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v3, :cond_2

    .end local v2    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$dispatch$lane$1":I
    monitor-exit v0

    return v1

    .line 53
    .restart local v2    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$dispatch$lane$1":I
    :cond_2
    :try_start_1
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->lanes:Ljava/util/concurrent/ConcurrentHashMap;

    new-instance v3, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$dispatch$lane$1$1;

    invoke-direct {v3, p0, p1}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$dispatch$lane$1$1;-><init>(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Ljava/lang/Object;)V

    check-cast v3, Lkotlin/jvm/functions/Function1;

    new-instance v4, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$$ExternalSyntheticLambda1;

    invoke-direct {v4, v3}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$$ExternalSyntheticLambda1;-><init>(Lkotlin/jvm/functions/Function1;)V

    invoke-virtual {v1, p1, v4}, Ljava/util/concurrent/ConcurrentHashMap;->computeIfAbsent(Ljava/lang/Object;Ljava/util/function/Function;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 48
    .end local v2    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$dispatch$lane$1":I
    monitor-exit v0

    const-string/jumbo v0, "synchronized(lifecycleLo\u2026Lane(key) }\n            }"

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v0, v1

    .line 55
    .local v0, "lane":Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;
    invoke-virtual {v0, p2}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->submit(Lkotlin/jvm/functions/Function0;)Z

    move-result v1

    if-eqz v1, :cond_3

    const/4 v1, 0x1

    return v1

    .line 56
    :cond_3
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->lanes:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v1, p1, v0}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;Ljava/lang/Object;)Z

    goto :goto_0

    .line 48
    .end local v0    # "lane":Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public final laneCountForTest$sdk_common_ability_release()I
    .locals 1

    .line 75
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->lanes:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v0}, Ljava/util/concurrent/ConcurrentHashMap;->size()I

    move-result v0

    return v0
.end method

.method public final remove(Ljava/lang/Object;)V
    .locals 1
    .param p1, "key"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;)V"
        }
    .end annotation

    .line 61
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->lanes:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->close()V

    .line 62
    :cond_0
    return-void
.end method

.method public final workerCountForKeyForTest$sdk_common_ability_release(Ljava/lang/Object;)I
    .locals 3
    .param p1, "key"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;)I"
        }
    .end annotation

    .line 78
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workerCapacityLock:Ljava/lang/Object;

    monitor-enter v0

    .line 227
    const/4 v1, 0x0

    .line 78
    .local v1, "$i$a$-synchronized-BoundedLatestTaskDispatcher$workerCountForKeyForTest$1":I
    :try_start_0
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workersPerKey:Ljava/util/Map;

    invoke-interface {v2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    .end local v1    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$workerCountForKeyForTest$1":I
    :goto_0
    monitor-exit v0

    return v2

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public final workerCountForTest$sdk_common_ability_release()I
    .locals 3

    .line 76
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workerCapacityLock:Ljava/lang/Object;

    monitor-enter v0

    .line 227
    const/4 v1, 0x0

    .line 76
    .local v1, "$i$a$-synchronized-BoundedLatestTaskDispatcher$workerCountForTest$1":I
    :try_start_0
    iget v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->workerCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v1    # "$i$a$-synchronized-BoundedLatestTaskDispatcher$workerCountForTest$1":I
    monitor-exit v0

    return v2

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method
