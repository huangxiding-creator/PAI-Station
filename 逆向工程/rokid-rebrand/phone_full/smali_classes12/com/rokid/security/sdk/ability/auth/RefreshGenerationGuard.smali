.class public final Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;
.super Ljava/lang/Object;
.source "RefreshGenerationGuard.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;,
        Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00006\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0004\u0008\u0000\u0018\u00002\u00020\u0001:\u0002\u0013\u0014B\u0005\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\t\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\u0004J\u000e\u0010\u000c\u001a\u00020\r2\u0006\u0010\u000e\u001a\u00020\u000fJ\u000e\u0010\u000c\u001a\u00020\r2\u0006\u0010\u000e\u001a\u00020\nJ\u0006\u0010\u0010\u001a\u00020\u0011J\u0010\u0010\u0012\u001a\u0004\u0018\u00010\u000f2\u0006\u0010\u000e\u001a\u00020\nR\u0010\u0010\u0003\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0012\u0010\u0005\u001a\u0004\u0018\u00010\u0006X\u0082\u000e\u00a2\u0006\u0004\n\u0002\u0010\u0007R\u000e\u0010\u0008\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0015"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;",
        "",
        "()V",
        "activeKey",
        "",
        "failureGeneration",
        "",
        "Ljava/lang/Long;",
        "generation",
        "begin",
        "Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;",
        "key",
        "isCurrent",
        "",
        "lease",
        "Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;",
        "stop",
        "",
        "tryBeginFailure",
        "FailureLease",
        "RefreshLease",
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
.field private activeKey:Ljava/lang/String;

.field private failureGeneration:Ljava/lang/Long;

.field private generation:J


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final declared-synchronized begin(Ljava/lang/String;)Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .locals 4
    .param p1, "key"    # Ljava/lang/String;

    monitor-enter p0

    :try_start_0
    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 23
    iget-wide v0, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->generation:J

    const-wide/16 v2, 0x1

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->generation:J

    .line 24
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->activeKey:Ljava/lang/String;

    .line 25
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->failureGeneration:Ljava/lang/Long;

    .line 26
    new-instance v0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;

    iget-wide v1, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->generation:J

    invoke-direct {v0, p1, v1, v2}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;-><init>(Ljava/lang/String;J)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 22
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;
    .end local p1    # "key":Ljava/lang/String;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final declared-synchronized isCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;)Z
    .locals 5
    .param p1, "lease"    # Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;

    monitor-enter p0

    :try_start_0
    const-string v0, "lease"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 44
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->activeKey:Ljava/lang/String;

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->failureGeneration:Ljava/lang/Long;

    invoke-virtual {p1}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;->getGeneration()J

    move-result-wide v1

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    cmp-long v0, v3, v1

    if-nez v0, :cond_1

    .line 45
    iget-wide v0, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->generation:J

    invoke-virtual {p1}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;->getGeneration()J

    move-result-wide v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    cmp-long v0, v0, v2

    if-nez v0, :cond_1

    const/4 v0, 0x1

    goto :goto_1

    .end local p0    # "this":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;
    :cond_1
    :goto_0
    const/4 v0, 0x0

    :goto_1
    monitor-exit p0

    return v0

    .line 43
    .end local p1    # "lease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final declared-synchronized isCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;)Z
    .locals 4
    .param p1, "lease"    # Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;

    monitor-enter p0

    :try_start_0
    const-string v0, "lease"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 31
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->activeKey:Ljava/lang/String;

    invoke-virtual {p1}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;->getKey()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-wide v0, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->generation:J

    invoke-virtual {p1}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;->getGeneration()J

    move-result-wide v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    .end local p0    # "this":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;
    :cond_0
    const/4 v0, 0x0

    :goto_0
    monitor-exit p0

    return v0

    .line 31
    .end local p1    # "lease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final declared-synchronized stop()V
    .locals 4

    monitor-enter p0

    .line 49
    :try_start_0
    iget-wide v0, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->generation:J

    const-wide/16 v2, 0x1

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->generation:J

    .line 50
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->activeKey:Ljava/lang/String;

    .line 51
    iput-object v0, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->failureGeneration:Ljava/lang/Long;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 52
    monitor-exit p0

    return-void

    .line 48
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized tryBeginFailure(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;)Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;
    .locals 6
    .param p1, "lease"    # Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;

    monitor-enter p0

    :try_start_0
    const-string v0, "lease"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 35
    invoke-virtual {p0, p1}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->isCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;)Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    monitor-exit p0

    return-object v1

    .line 36
    :cond_0
    :try_start_1
    iget-wide v2, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->generation:J

    const-wide/16 v4, 0x1

    add-long/2addr v2, v4

    iput-wide v2, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->generation:J

    .line 37
    iput-object v1, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->activeKey:Ljava/lang/String;

    .line 38
    iget-wide v0, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->generation:J

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->failureGeneration:Ljava/lang/Long;

    .line 39
    new-instance v0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;

    iget-wide v1, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->generation:J

    invoke-direct {v0, v1, v2}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;-><init>(J)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit p0

    return-object v0

    .line 34
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;
    .end local p1    # "lease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method
