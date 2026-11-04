.class public final Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;
.super Ljava/lang/Object;
.source "AsrTaskLifecycle.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u000b\u0008\u0000\u0018\u00002\u00020\u0001:\u0001\u0016B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0007\u001a\u00020\u0008J\u000e\u0010\t\u001a\u00020\u00082\u0006\u0010\n\u001a\u00020\u0006J\u000e\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u0006J\u000e\u0010\u000e\u001a\u00020\u00082\u0006\u0010\u000f\u001a\u00020\u0006J\u0008\u0010\u0010\u001a\u0004\u0018\u00010\u0006J\u000e\u0010\u0011\u001a\u00020\u00082\u0006\u0010\n\u001a\u00020\u0006J\u0006\u0010\u0012\u001a\u00020\u000cJ\u0008\u0010\u0013\u001a\u0004\u0018\u00010\u0006J\u0010\u0010\u0014\u001a\u0004\u0018\u00010\u00042\u0006\u0010\n\u001a\u00020\u0006J\u0008\u0010\u0015\u001a\u0004\u0018\u00010\u0004R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0005\u001a\u0004\u0018\u00010\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0017"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;",
        "",
        "()V",
        "state",
        "Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;",
        "taskId",
        "",
        "acceptsAudio",
        "",
        "acceptsResult",
        "responseTaskId",
        "begin",
        "",
        "newTaskId",
        "canReplayStart",
        "replayTaskId",
        "currentTaskId",
        "markStarted",
        "markTransportLost",
        "requestStop",
        "terminate",
        "terminateCurrent",
        "State",
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
.field private state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

.field private taskId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->IDLE:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    .line 9
    return-void
.end method


# virtual methods
.method public final declared-synchronized acceptsAudio()Z
    .locals 2

    monitor-enter p0

    .line 38
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    sget-object v1, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->RUNNING:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    monitor-exit p0

    return v0

    .line 38
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized acceptsResult(Ljava/lang/String;)Z
    .locals 2
    .param p1, "responseTaskId"    # Ljava/lang/String;

    monitor-enter p0

    :try_start_0
    const-string v0, "responseTaskId"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 35
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->taskId:Ljava/lang/String;

    invoke-static {v0, p1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    sget-object v1, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->STARTING:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    sget-object v1, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->RUNNING:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-ne v0, v1, :cond_1

    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;
    :cond_0
    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    monitor-exit p0

    return v0

    .line 35
    .end local p1    # "responseTaskId":Ljava/lang/String;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final declared-synchronized begin(Ljava/lang/String;)V
    .locals 1
    .param p1, "newTaskId"    # Ljava/lang/String;

    monitor-enter p0

    :try_start_0
    const-string v0, "newTaskId"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 22
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->taskId:Ljava/lang/String;

    .line 23
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->STARTING:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 24
    monitor-exit p0

    return-void

    .line 21
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;
    .end local p1    # "newTaskId":Ljava/lang/String;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final declared-synchronized canReplayStart(Ljava/lang/String;)Z
    .locals 2
    .param p1, "replayTaskId"    # Ljava/lang/String;

    monitor-enter p0

    :try_start_0
    const-string v0, "replayTaskId"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 70
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->taskId:Ljava/lang/String;

    invoke-static {v0, p1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    sget-object v1, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->STARTING:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    sget-object v1, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->RUNNING:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-ne v0, v1, :cond_1

    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;
    :cond_0
    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    monitor-exit p0

    return v0

    .line 70
    .end local p1    # "replayTaskId":Ljava/lang/String;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final declared-synchronized currentTaskId()Ljava/lang/String;
    .locals 1

    monitor-enter p0

    .line 73
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->taskId:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 73
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized markStarted(Ljava/lang/String;)Z
    .locals 2
    .param p1, "responseTaskId"    # Ljava/lang/String;

    monitor-enter p0

    :try_start_0
    const-string v0, "responseTaskId"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 28
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->taskId:Ljava/lang/String;

    invoke-static {v0, p1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    sget-object v1, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->STARTING:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    if-eq v0, v1, :cond_0

    goto :goto_0

    .line 29
    :cond_0
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->RUNNING:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 30
    monitor-exit p0

    const/4 v0, 0x1

    return v0

    .line 28
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;
    :cond_1
    :goto_0
    monitor-exit p0

    const/4 v0, 0x0

    return v0

    .line 27
    .end local p1    # "responseTaskId":Ljava/lang/String;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final declared-synchronized markTransportLost()V
    .locals 2

    monitor-enter p0

    .line 65
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    sget-object v1, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->RUNNING:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    if-ne v0, v1, :cond_0

    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->STARTING:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 66
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;
    :cond_0
    monitor-exit p0

    return-void

    .line 64
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized requestStop()Ljava/lang/String;
    .locals 2

    monitor-enter p0

    .line 42
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    sget-object v1, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->STARTING:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    sget-object v1, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->RUNNING:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eq v0, v1, :cond_0

    monitor-exit p0

    const/4 v0, 0x0

    return-object v0

    .line 43
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;
    :cond_0
    :try_start_1
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->STOPPING:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    .line 44
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->taskId:Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit p0

    return-object v0

    .line 41
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized terminate(Ljava/lang/String;)Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;
    .locals 3
    .param p1, "responseTaskId"    # Ljava/lang/String;

    monitor-enter p0

    :try_start_0
    const-string v0, "responseTaskId"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 50
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->taskId:Ljava/lang/String;

    invoke-static {v0, p1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    sget-object v2, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->IDLE:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    if-ne v0, v2, :cond_0

    goto :goto_0

    .line 51
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    .line 52
    .local v0, "previous":Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;
    iput-object v1, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->taskId:Ljava/lang/String;

    .line 53
    sget-object v1, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->IDLE:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    iput-object v1, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->state:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 54
    monitor-exit p0

    return-object v0

    .line 50
    .end local v0    # "previous":Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;
    :cond_1
    :goto_0
    monitor-exit p0

    return-object v1

    .line 49
    .end local p1    # "responseTaskId":Ljava/lang/String;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final declared-synchronized terminateCurrent()Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;
    .locals 2

    monitor-enter p0

    .line 59
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->taskId:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    monitor-exit p0

    const/4 v0, 0x0

    return-object v0

    .line 60
    .local v0, "current":Ljava/lang/String;
    :cond_0
    :try_start_1
    invoke-virtual {p0, v0}, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->terminate(Ljava/lang/String;)Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    move-result-object v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit p0

    return-object v1

    .line 58
    .end local v0    # "current":Ljava/lang/String;
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
