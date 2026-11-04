.class public final Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample$Companion;
.super Ljava/lang/Object;
.source "RokidRFMVadExample.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000 \n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u0008J\u000e\u0010\t\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u0008R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\n"
    }
    d2 = {
        "Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample$Companion;",
        "",
        "()V",
        "TAG",
        "",
        "vadAsyncExample",
        "",
        "context",
        "Landroid/content/Context;",
        "vadExample",
        "lib-rfmlite_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public static synthetic $r8$lambda$aKZRZAJIgMn70g82ykxFOUfKxjY(Landroid/content/Context;)V
    .locals 0

    invoke-static {p0}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample$Companion;->vadAsyncExample$lambda$0(Landroid/content/Context;)V

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public synthetic constructor <init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    invoke-direct {p0}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample$Companion;-><init>()V

    return-void
.end method

.method private static final vadAsyncExample$lambda$0(Landroid/content/Context;)V
    .locals 4
    .param p0, "$context"    # Landroid/content/Context;

    const-string v0, "$context"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 110
    nop

    .line 111
    :try_start_0
    sget-object v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample;->Companion:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample$Companion;

    invoke-virtual {v0, p0}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample$Companion;->vadExample(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 112
    :catch_0
    move-exception v0

    .line 113
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "VAD async example error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const-string v3, "RokidRFMVadExample"

    invoke-static {v3, v1, v2}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 115
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method


# virtual methods
.method public final vadAsyncExample(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    const-string v0, "context"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 109
    new-instance v0, Ljava/lang/Thread;

    .line 115
    new-instance v1, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample$Companion$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample$Companion$$ExternalSyntheticLambda0;-><init>(Landroid/content/Context;)V

    .line 109
    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 115
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 116
    return-void
.end method

.method public final vadExample(Landroid/content/Context;)V
    .locals 14
    .param p1, "context"    # Landroid/content/Context;

    const-string v0, "context"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 20
    const-string/jumbo v0, "test_device_001"

    .line 21
    .local v0, "deviceId":Ljava/lang/String;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "trace_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 24
    .local v8, "traceId":Ljava/lang/String;
    const/16 v9, 0x1f40

    .line 25
    .local v9, "timeoutMs":I
    sget-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->INSTANCE:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;

    const/16 v6, 0x8

    const/4 v7, 0x0

    const/4 v5, 0x0

    move-object v2, p1

    move-object v3, v0

    move v4, v9

    invoke-static/range {v1 .. v7}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->create$default(Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;Landroid/content/Context;Ljava/lang/String;ILjava/lang/String;ILjava/lang/Object;)Z

    move-result v1

    .line 26
    .local v1, "createSuccess":Z
    const-string v2, "RokidRFMVadExample"

    const/4 v3, 0x0

    if-nez v1, :cond_0

    .line 27
    const-string v4, "Failed to create VAD engine"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v2, v4, v3}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 28
    return-void

    .line 32
    :cond_0
    new-instance v4, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample$Companion$vadExample$vadCallback$1;

    invoke-direct {v4}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample$Companion$vadExample$vadCallback$1;-><init>()V

    .line 58
    .local v4, "vadCallback":Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample$Companion$vadExample$vadCallback$1;
    sget-object v5, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->INSTANCE:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;

    move-object v6, v4

    check-cast v6, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadCallback;

    invoke-virtual {v5, v8, v6}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->start(Ljava/lang/String;Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadCallback;)Z

    move-result v5

    .line 59
    .local v5, "startSuccess":Z
    if-nez v5, :cond_1

    .line 60
    const-string v6, "Failed to start VAD session"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v2, v6, v3}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 61
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->INSTANCE:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->release()V

    .line 62
    return-void

    .line 67
    :cond_1
    const/4 v6, 0x5

    new-array v6, v6, [Ljava/lang/String;

    const-string/jumbo v7, "\u4f60\u597d"

    aput-object v7, v6, v3

    .line 68
    const-string/jumbo v7, "\u4f60\u597d\uff0c"

    const/4 v10, 0x1

    aput-object v7, v6, v10

    .line 67
    nop

    .line 69
    const-string/jumbo v7, "\u4f60\u597d\uff0c\u4eca\u5929"

    const/4 v10, 0x2

    aput-object v7, v6, v10

    .line 67
    nop

    .line 70
    const-string/jumbo v7, "\u4f60\u597d\uff0c\u4eca\u5929\u5929\u6c14"

    const/4 v10, 0x3

    aput-object v7, v6, v10

    .line 67
    nop

    .line 71
    const-string/jumbo v7, "\u4f60\u597d\uff0c\u4eca\u5929\u5929\u6c14\u600e\u4e48\u6837"

    const/4 v10, 0x4

    aput-object v7, v6, v10

    .line 67
    nop

    .line 66
    invoke-static {v6}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v6

    .line 74
    .local v6, "asrTexts":Ljava/util/List;
    invoke-interface {v6}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_0
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    if-eqz v10, :cond_3

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/String;

    .line 75
    .local v10, "text":Ljava/lang/String;
    sget-object v11, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->INSTANCE:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;

    invoke-virtual {v11, v10, v8}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->feed(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v11

    .line 76
    .local v11, "feedSuccess":Z
    if-nez v11, :cond_2

    .line 77
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Failed to feed ASR text: "

    invoke-virtual {v7, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    new-array v12, v3, [Ljava/lang/Object;

    invoke-static {v2, v7, v12}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 78
    goto :goto_1

    .line 82
    :cond_2
    nop

    .line 83
    const-wide/16 v12, 0xc8

    :try_start_0
    invoke-static {v12, v13}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 84
    :catch_0
    move-exception v7

    .line 85
    .local v7, "e":Ljava/lang/InterruptedException;
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/Thread;->interrupt()V

    .line 86
    nop

    .line 91
    .end local v7    # "e":Ljava/lang/InterruptedException;
    .end local v10    # "text":Ljava/lang/String;
    .end local v11    # "feedSuccess":Z
    :cond_3
    :goto_1
    sget-object v7, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->INSTANCE:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;

    invoke-virtual {v7, v8}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->stop(Ljava/lang/String;)Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadFinalResult;

    move-result-object v7

    .line 92
    .local v7, "finalResult":Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadFinalResult;
    if-eqz v7, :cond_4

    .line 93
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "VAD\u6700\u7ec8\u7ed3\u679c: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    new-array v11, v3, [Ljava/lang/Object;

    invoke-static {v2, v10, v11}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->dWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 94
    invoke-virtual {v7}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadFinalResult;->getAsr()Ljava/lang/String;

    move-result-object v10

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v12, "\u6700\u7ec8ASR\u6587\u672c: "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    new-array v11, v3, [Ljava/lang/Object;

    invoke-static {v2, v10, v11}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->dWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 95
    invoke-virtual {v7}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadFinalResult;->getVads()Ljava/util/List;

    move-result-object v10

    invoke-interface {v10}, Ljava/util/List;->size()I

    move-result v10

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "VAD\u4e34\u65f6\u7ed3\u679c\u6570\u91cf: "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    new-array v11, v3, [Ljava/lang/Object;

    invoke-static {v2, v10, v11}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->dWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_2

    .line 97
    :cond_4
    const-string v10, "Failed to get VAD final result"

    new-array v11, v3, [Ljava/lang/Object;

    invoke-static {v2, v10, v11}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 101
    :goto_2
    sget-object v10, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->INSTANCE:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;

    invoke-virtual {v10}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->release()V

    .line 102
    const-string v10, "VAD example completed"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v2, v10, v3}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->dWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 103
    return-void
.end method
