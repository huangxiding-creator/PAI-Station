.class public final Lcom/rokid/aicore/api/AIEngine$Companion;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/aicore/api/AIEngine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\"\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0002\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0007\u001a\u00020\u0006J\u0008\u0010\u0008\u001a\u00020\tH\u0007J\u0008\u0010\n\u001a\u00020\tH\u0007R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0005\u001a\u0004\u0018\u00010\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000b"
    }
    d2 = {
        "Lcom/rokid/aicore/api/AIEngine$Companion;",
        "",
        "()V",
        "TAG",
        "",
        "instance",
        "Lcom/rokid/aicore/api/AIEngine;",
        "getInstance",
        "getQnnRuntimeState",
        "",
        "prepareQnnRuntime",
        "aicore_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x5,
        0x1
    }
    xi = 0x30
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public synthetic constructor <init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    invoke-direct {p0}, Lcom/rokid/aicore/api/AIEngine$Companion;-><init>()V

    return-void
.end method


# virtual methods
.method public final getInstance()Lcom/rokid/aicore/api/AIEngine;
    .locals 2

    invoke-static {}, Lcom/rokid/aicore/api/AIEngine;->access$getInstance$cp()Lcom/rokid/aicore/api/AIEngine;

    move-result-object v0

    if-nez v0, :cond_1

    monitor-enter p0

    :try_start_0
    invoke-static {}, Lcom/rokid/aicore/api/AIEngine;->access$getInstance$cp()Lcom/rokid/aicore/api/AIEngine;

    move-result-object v0

    if-nez v0, :cond_0

    new-instance v0, Lcom/rokid/aicore/api/AIEngine;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/aicore/api/AIEngine;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sget-object v1, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    invoke-static {v0}, Lcom/rokid/aicore/api/AIEngine;->access$setInstance$cp(Lcom/rokid/aicore/api/AIEngine;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit p0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :cond_1
    :goto_0
    return-object v0
.end method

.method public final getQnnRuntimeState()I
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    invoke-static {}, Lcom/rokid/aicore/ncnn/MotWrapper;->getQnnRuntimeState()I

    move-result v0

    return v0
.end method

.method public final prepareQnnRuntime()I
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    invoke-static {}, Lcom/rokid/aicore/ncnn/MotWrapper;->prepareQnnRuntime()I

    move-result v0

    return v0
.end method
