.class public final Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;
.super Ljava/lang/Object;
.source "AsrStartRecovery.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nAsrStartRecovery.kt\nKotlin\n*S Kotlin\n*F\n+ 1 AsrStartRecovery.kt\ncom/rokid/security/sdk/ability/asr/AsrStartRecovery\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,38:1\n1#2:39\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000&\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0008\u0008\u0000\u0018\u00002\u00020\u0001:\u0001\u0011B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0016\u0010\u0007\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\nJ\u0006\u0010\u000c\u001a\u00020\u0008J\u0008\u0010\r\u001a\u0004\u0018\u00010\u0004J\u0016\u0010\u000e\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\n2\u0006\u0010\u000f\u001a\u00020\u0006J\u0006\u0010\u0010\u001a\u00020\u0008R\u0010\u0010\u0003\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0012"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;",
        "",
        "()V",
        "request",
        "Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;",
        "sentOnCurrentConnection",
        "",
        "begin",
        "",
        "taskId",
        "",
        "message",
        "cancel",
        "nextToSend",
        "onSendResult",
        "accepted",
        "onTransportLost",
        "Request",
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
.field private request:Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;

.field private sentOnCurrentConnection:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final declared-synchronized begin(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "taskId"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;

    monitor-enter p0

    :try_start_0
    const-string/jumbo v0, "taskId"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "message"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 15
    new-instance v0, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;

    invoke-direct {v0, p1, p2}, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->request:Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;

    .line 16
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->sentOnCurrentConnection:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 17
    monitor-exit p0

    return-void

    .line 14
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;
    .end local p1    # "taskId":Ljava/lang/String;
    .end local p2    # "message":Ljava/lang/String;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final declared-synchronized cancel()V
    .locals 1

    monitor-enter p0

    .line 34
    const/4 v0, 0x0

    :try_start_0
    iput-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->request:Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;

    .line 35
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->sentOnCurrentConnection:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 36
    monitor-exit p0

    return-void

    .line 33
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized nextToSend()Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;
    .locals 5

    monitor-enter p0

    .line 20
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->request:Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    move-object v2, v0

    .line 39
    .local v2, "it":Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;
    const/4 v3, 0x0

    .line 20
    .local v3, "$i$a$-takeUnless-AsrStartRecovery$nextToSend$1":I
    iget-boolean v4, p0, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->sentOnCurrentConnection:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v2    # "it":Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;
    .end local v3    # "$i$a$-takeUnless-AsrStartRecovery$nextToSend$1":I
    if-nez v4, :cond_0

    goto :goto_0

    :cond_0
    move-object v0, v1

    goto :goto_0

    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;
    :cond_1
    move-object v0, v1

    :goto_0
    monitor-exit p0

    return-object v0

    .line 19
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized onSendResult(Ljava/lang/String;Z)V
    .locals 1
    .param p1, "taskId"    # Ljava/lang/String;
    .param p2, "accepted"    # Z

    monitor-enter p0

    :try_start_0
    const-string/jumbo v0, "taskId"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->request:Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;->getTaskId()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;
    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-static {v0, p1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    if-eqz p2, :cond_1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->sentOnCurrentConnection:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 25
    :cond_1
    monitor-exit p0

    return-void

    .line 23
    .end local p1    # "taskId":Ljava/lang/String;
    .end local p2    # "accepted":Z
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final declared-synchronized onTransportLost()V
    .locals 1

    monitor-enter p0

    .line 29
    const/4 v0, 0x0

    :try_start_0
    iput-boolean v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->sentOnCurrentConnection:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 30
    monitor-exit p0

    return-void

    .line 28
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
