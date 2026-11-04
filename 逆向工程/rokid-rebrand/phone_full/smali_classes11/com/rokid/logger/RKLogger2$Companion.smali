.class public final Lcom/rokid/logger/RKLogger2$Companion;
.super Ljava/lang/Object;
.source "RKLogger2.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/logger/RKLogger2;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000,\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010%\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u000b\n\u0002\u0018\u0002\n\u0002\u0008\u0007\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0008\u0010\u0008\u001a\u00020\tH\u0002J\u001a\u0010\n\u001a\u00020\t2\u0006\u0010\u000b\u001a\u00020\u00072\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u0012\u0010\n\u001a\u00020\t2\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u001a\u0010\r\u001a\u00020\t2\u0006\u0010\u000b\u001a\u00020\u00072\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u0012\u0010\r\u001a\u00020\t2\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u001a\u0010\u000e\u001a\u00020\t2\u0006\u0010\u000b\u001a\u00020\u00072\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u0012\u0010\u000e\u001a\u00020\t2\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u001a\u0010\u000f\u001a\u00020\t2\u0006\u0010\u000b\u001a\u00020\u00072\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u0012\u0010\u000f\u001a\u00020\t2\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\n\u0010\u0010\u001a\u0004\u0018\u00010\u0007H\u0007J\u001a\u0010\u0011\u001a\u00020\t2\u0006\u0010\u000b\u001a\u00020\u00072\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u0012\u0010\u0011\u001a\u00020\t2\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u001a\u0010\u0012\u001a\u00020\t2\u0006\u0010\u000b\u001a\u00020\u00072\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u0012\u0010\u0012\u001a\u00020\t2\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u0010\u0010\u0013\u001a\u00020\t2\u0006\u0010\u0014\u001a\u00020\u0015H\u0007J\u001a\u0010\u0016\u001a\u0004\u0018\u00010\u00042\u0006\u0010\u0017\u001a\u00020\u00072\u0006\u0010\u0014\u001a\u00020\u0015H\u0007J\u001a\u0010\u0018\u001a\u00020\t2\u0006\u0010\u000b\u001a\u00020\u00072\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u0012\u0010\u0018\u001a\u00020\t2\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u001a\u0010\u0019\u001a\u00020\t2\u0006\u0010\u000b\u001a\u00020\u00072\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u0012\u0010\u0019\u001a\u00020\t2\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u001a\u0010\u001a\u001a\u00020\t2\u0006\u0010\u000b\u001a\u00020\u00072\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u0012\u0010\u001a\u001a\u00020\t2\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u001a\u0010\u001b\u001a\u00020\t2\u0006\u0010\u000b\u001a\u00020\u00072\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007J\u0012\u0010\u001b\u001a\u00020\t2\u0008\u0010\u000c\u001a\u0004\u0018\u00010\u0007H\u0007R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u0005\u001a\u000e\u0012\u0004\u0012\u00020\u0007\u0012\u0004\u0012\u00020\u00040\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001c"
    }
    d2 = {
        "Lcom/rokid/logger/RKLogger2$Companion;",
        "",
        "()V",
        "DEFAULT_LOGGER",
        "Lcom/rokid/logger/RKLogger2;",
        "loggerMap",
        "",
        "",
        "checkInit",
        "",
        "d",
        "tag",
        "message",
        "debug",
        "e",
        "error",
        "getLogPath",
        "i",
        "info",
        "initDefaultConfig",
        "config",
        "Lcom/rokid/logger/manager/LogcatConfig;",
        "newInstance",
        "module",
        "v",
        "verbose",
        "w",
        "warning",
        "logger_release"
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

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public synthetic constructor <init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    invoke-direct {p0}, Lcom/rokid/logger/RKLogger2$Companion;-><init>()V

    return-void
.end method

.method private final checkInit()V
    .locals 0

    .line 160
    return-void
.end method


# virtual methods
.method public final d(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    .line 71
    invoke-direct {p0}, Lcom/rokid/logger/RKLogger2$Companion;->checkInit()V

    .line 72
    const-string v0, ""

    invoke-virtual {p0, v0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 73
    return-void
.end method

.method public final d(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 65
    invoke-direct {p0}, Lcom/rokid/logger/RKLogger2$Companion;->checkInit()V

    .line 66
    invoke-static {}, Lcom/rokid/logger/RKLogger2;->access$getDEFAULT_LOGGER$cp()Lcom/rokid/logger/RKLogger2;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/rokid/logger/RKLogger2;->D(Ljava/lang/String;Ljava/lang/String;)V

    .line 67
    return-void
.end method

.method public final debug(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    .line 82
    const-string v0, ""

    invoke-virtual {p0, v0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 83
    return-void
.end method

.method public final debug(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 77
    invoke-virtual {p0, p1, p2}, Lcom/rokid/logger/RKLogger2$Companion;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 78
    return-void
.end method

.method public final e(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    .line 137
    invoke-direct {p0}, Lcom/rokid/logger/RKLogger2$Companion;->checkInit()V

    .line 138
    const-string v0, ""

    invoke-virtual {p0, v0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 139
    return-void
.end method

.method public final e(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 131
    invoke-direct {p0}, Lcom/rokid/logger/RKLogger2$Companion;->checkInit()V

    .line 132
    invoke-static {}, Lcom/rokid/logger/RKLogger2;->access$getDEFAULT_LOGGER$cp()Lcom/rokid/logger/RKLogger2;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/rokid/logger/RKLogger2;->E(Ljava/lang/String;Ljava/lang/String;)V

    .line 133
    return-void
.end method

.method public final error(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    .line 148
    const-string v0, ""

    invoke-virtual {p0, v0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 149
    return-void
.end method

.method public final error(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 143
    invoke-virtual {p0, p1, p2}, Lcom/rokid/logger/RKLogger2$Companion;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 144
    return-void
.end method

.method public final getLogPath()Ljava/lang/String;
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    .line 153
    invoke-static {}, Lcom/rokid/logger/RKLogger2;->access$getDEFAULT_LOGGER$cp()Lcom/rokid/logger/RKLogger2;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/logger/RKLogger2;->access$getMLogcatConfig$p(Lcom/rokid/logger/RKLogger2;)Lcom/rokid/logger/manager/LogcatConfig;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Lcom/rokid/logger/manager/LogcatConfig;->getFilePath()Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0
.end method

.method public final i(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    .line 93
    invoke-direct {p0}, Lcom/rokid/logger/RKLogger2$Companion;->checkInit()V

    .line 94
    const-string v0, ""

    invoke-virtual {p0, v0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->i(Ljava/lang/String;Ljava/lang/String;)V

    .line 95
    return-void
.end method

.method public final i(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 87
    invoke-direct {p0}, Lcom/rokid/logger/RKLogger2$Companion;->checkInit()V

    .line 88
    invoke-static {}, Lcom/rokid/logger/RKLogger2;->access$getDEFAULT_LOGGER$cp()Lcom/rokid/logger/RKLogger2;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/rokid/logger/RKLogger2;->I(Ljava/lang/String;Ljava/lang/String;)V

    .line 89
    return-void
.end method

.method public final info(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    .line 104
    const-string v0, ""

    invoke-virtual {p0, v0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->i(Ljava/lang/String;Ljava/lang/String;)V

    .line 105
    return-void
.end method

.method public final info(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 99
    invoke-virtual {p0, p1, p2}, Lcom/rokid/logger/RKLogger2$Companion;->i(Ljava/lang/String;Ljava/lang/String;)V

    .line 100
    return-void
.end method

.method public final initDefaultConfig(Lcom/rokid/logger/manager/LogcatConfig;)V
    .locals 1
    .param p1, "config"    # Lcom/rokid/logger/manager/LogcatConfig;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const-string v0, "config"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    invoke-static {}, Lcom/rokid/logger/RKLogger2;->access$getDEFAULT_LOGGER$cp()Lcom/rokid/logger/RKLogger2;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/rokid/logger/RKLogger2;->access$setLogcatConfig(Lcom/rokid/logger/RKLogger2;Lcom/rokid/logger/manager/LogcatConfig;)V

    .line 25
    return-void
.end method

.method public final newInstance(Ljava/lang/String;Lcom/rokid/logger/manager/LogcatConfig;)Lcom/rokid/logger/RKLogger2;
    .locals 4
    .param p1, "module"    # Ljava/lang/String;
    .param p2, "config"    # Lcom/rokid/logger/manager/LogcatConfig;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const-string v0, "module"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "config"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 29
    invoke-static {}, Lcom/rokid/logger/RKLogger2;->access$getLoggerMap$cp()Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const-class v0, Lcom/rokid/logger/RKLogger2;

    .line 30
    monitor-enter v0

    const/4 v1, 0x0

    .line 31
    .local v1, "$i$a$-synchronized-RKLogger2$Companion$newInstance$1":I
    :try_start_0
    invoke-static {}, Lcom/rokid/logger/RKLogger2;->access$getLoggerMap$cp()Ljava/util/Map;

    move-result-object v2

    invoke-interface {v2, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 32
    new-instance v2, Lcom/rokid/logger/RKLogger2;

    invoke-direct {v2}, Lcom/rokid/logger/RKLogger2;-><init>()V

    .line 33
    .local v2, "logger":Lcom/rokid/logger/RKLogger2;
    invoke-static {}, Lcom/rokid/logger/RKLogger2;->access$getLoggerMap$cp()Ljava/util/Map;

    move-result-object v3

    invoke-interface {v3, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 35
    .end local v2    # "logger":Lcom/rokid/logger/RKLogger2;
    :cond_0
    nop

    .end local v1    # "$i$a$-synchronized-RKLogger2$Companion$newInstance$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 30
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1

    .line 37
    :cond_1
    :goto_0
    invoke-static {}, Lcom/rokid/logger/RKLogger2;->access$getLoggerMap$cp()Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    check-cast v0, Lcom/rokid/logger/RKLogger2;

    invoke-static {v0, p2}, Lcom/rokid/logger/RKLogger2;->access$setLogcatConfig(Lcom/rokid/logger/RKLogger2;Lcom/rokid/logger/manager/LogcatConfig;)V

    .line 38
    invoke-static {}, Lcom/rokid/logger/RKLogger2;->access$getLoggerMap$cp()Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/logger/RKLogger2;

    return-object v0
.end method

.method public final v(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    .line 49
    invoke-direct {p0}, Lcom/rokid/logger/RKLogger2$Companion;->checkInit()V

    .line 50
    const-string v0, ""

    invoke-virtual {p0, v0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->v(Ljava/lang/String;Ljava/lang/String;)V

    .line 51
    return-void
.end method

.method public final v(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 43
    invoke-direct {p0}, Lcom/rokid/logger/RKLogger2$Companion;->checkInit()V

    .line 44
    invoke-static {}, Lcom/rokid/logger/RKLogger2;->access$getDEFAULT_LOGGER$cp()Lcom/rokid/logger/RKLogger2;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/rokid/logger/RKLogger2;->verbose1(Ljava/lang/String;Ljava/lang/String;)V

    .line 45
    return-void
.end method

.method public final verbose(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    .line 60
    const-string v0, ""

    invoke-virtual {p0, v0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->v(Ljava/lang/String;Ljava/lang/String;)V

    .line 61
    return-void
.end method

.method public final verbose(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 55
    invoke-virtual {p0, p1, p2}, Lcom/rokid/logger/RKLogger2$Companion;->v(Ljava/lang/String;Ljava/lang/String;)V

    .line 56
    return-void
.end method

.method public final w(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    .line 115
    invoke-direct {p0}, Lcom/rokid/logger/RKLogger2$Companion;->checkInit()V

    .line 116
    const-string v0, ""

    invoke-virtual {p0, v0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->w(Ljava/lang/String;Ljava/lang/String;)V

    .line 117
    return-void
.end method

.method public final w(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 109
    invoke-direct {p0}, Lcom/rokid/logger/RKLogger2$Companion;->checkInit()V

    .line 110
    invoke-static {}, Lcom/rokid/logger/RKLogger2;->access$getDEFAULT_LOGGER$cp()Lcom/rokid/logger/RKLogger2;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/rokid/logger/RKLogger2;->W(Ljava/lang/String;Ljava/lang/String;)V

    .line 111
    return-void
.end method

.method public final warning(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    .line 126
    const-string v0, ""

    invoke-virtual {p0, v0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->w(Ljava/lang/String;Ljava/lang/String;)V

    .line 127
    return-void
.end method

.method public final warning(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 121
    invoke-virtual {p0, p1, p2}, Lcom/rokid/logger/RKLogger2$Companion;->w(Ljava/lang/String;Ljava/lang/String;)V

    .line 122
    return-void
.end method
