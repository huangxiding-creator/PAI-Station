.class public Lcom/rokid/logger/RKLogger2;
.super Ljava/lang/Object;
.source "RKLogger2.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/logger/RKLogger2$Companion;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nRKLogger2.kt\nKotlin\n*S Kotlin\n*F\n+ 1 RKLogger2.kt\ncom/rokid/logger/RKLogger2\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,260:1\n1#2:261\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000.\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\t\n\u0002\u0010\u0008\n\u0002\u0008\u0007\u0008\u0016\u0018\u0000 \u001a2\u00020\u0001:\u0001\u001aB\u0005\u00a2\u0006\u0002\u0010\u0002J\u0018\u0010\u0007\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\n2\u0008\u0010\u000b\u001a\u0004\u0018\u00010\nJ\u0018\u0010\u000c\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\n2\u0008\u0010\u000b\u001a\u0004\u0018\u00010\nJ\u0018\u0010\r\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\n2\u0008\u0010\u000b\u001a\u0004\u0018\u00010\nJ\u001f\u0010\u000e\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\n2\u0008\u0010\u000b\u001a\u0004\u0018\u00010\nH\u0007\u00a2\u0006\u0002\u0008\u000fJ\u0018\u0010\u0010\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\n2\u0008\u0010\u000b\u001a\u0004\u0018\u00010\nJ\u0008\u0010\u0011\u001a\u0004\u0018\u00010\u0006J \u0010\u0012\u001a\u00020\u00082\u0006\u0010\u0013\u001a\u00020\u00142\u0006\u0010\t\u001a\u00020\n2\u0006\u0010\u0015\u001a\u00020\nH\u0002J\"\u0010\u0016\u001a\u00020\u00082\u0006\u0010\u0013\u001a\u00020\u00142\u0006\u0010\t\u001a\u00020\n2\u0008\u0010\u000b\u001a\u0004\u0018\u00010\nH\u0002J\u001a\u0010\u0017\u001a\u00020\u00082\u0006\u0010\u0013\u001a\u00020\u00142\u0008\u0010\u000b\u001a\u0004\u0018\u00010\nH\u0002J\u0010\u0010\u0018\u001a\u00020\u00082\u0006\u0010\u0019\u001a\u00020\u0006H\u0002R\u0010\u0010\u0003\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0005\u001a\u0004\u0018\u00010\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001b"
    }
    d2 = {
        "Lcom/rokid/logger/RKLogger2;",
        "",
        "()V",
        "logger",
        "Lorg/slf4j/Logger;",
        "mLogcatConfig",
        "Lcom/rokid/logger/manager/LogcatConfig;",
        "D",
        "",
        "tag",
        "",
        "message",
        "E",
        "I",
        "V",
        "verbose1",
        "W",
        "getLogcatConfig",
        "printLog",
        "level",
        "",
        "printLogInfo",
        "readyPrintLog",
        "saveAndPrintLog",
        "setLogcatConfig",
        "logcatConfig",
        "Companion",
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


# static fields
.field public static final Companion:Lcom/rokid/logger/RKLogger2$Companion;

.field private static final DEFAULT_LOGGER:Lcom/rokid/logger/RKLogger2;

.field private static final loggerMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/rokid/logger/RKLogger2;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private logger:Lorg/slf4j/Logger;

.field private mLogcatConfig:Lcom/rokid/logger/manager/LogcatConfig;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/logger/RKLogger2$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/logger/RKLogger2$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    .line 19
    new-instance v0, Lcom/rokid/logger/RKLogger2;

    invoke-direct {v0}, Lcom/rokid/logger/RKLogger2;-><init>()V

    sput-object v0, Lcom/rokid/logger/RKLogger2;->DEFAULT_LOGGER:Lcom/rokid/logger/RKLogger2;

    .line 20
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    check-cast v0, Ljava/util/Map;

    sput-object v0, Lcom/rokid/logger/RKLogger2;->loggerMap:Ljava/util/Map;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$getDEFAULT_LOGGER$cp()Lcom/rokid/logger/RKLogger2;
    .locals 1

    .line 13
    sget-object v0, Lcom/rokid/logger/RKLogger2;->DEFAULT_LOGGER:Lcom/rokid/logger/RKLogger2;

    return-object v0
.end method

.method public static final synthetic access$getLoggerMap$cp()Ljava/util/Map;
    .locals 1

    .line 13
    sget-object v0, Lcom/rokid/logger/RKLogger2;->loggerMap:Ljava/util/Map;

    return-object v0
.end method

.method public static final synthetic access$getMLogcatConfig$p(Lcom/rokid/logger/RKLogger2;)Lcom/rokid/logger/manager/LogcatConfig;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/logger/RKLogger2;

    .line 13
    iget-object v0, p0, Lcom/rokid/logger/RKLogger2;->mLogcatConfig:Lcom/rokid/logger/manager/LogcatConfig;

    return-object v0
.end method

.method public static final synthetic access$setLogcatConfig(Lcom/rokid/logger/RKLogger2;Lcom/rokid/logger/manager/LogcatConfig;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/logger/RKLogger2;
    .param p1, "logcatConfig"    # Lcom/rokid/logger/manager/LogcatConfig;

    .line 13
    invoke-direct {p0, p1}, Lcom/rokid/logger/RKLogger2;->setLogcatConfig(Lcom/rokid/logger/manager/LogcatConfig;)V

    return-void
.end method

.method public static final d(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0}, Lcom/rokid/logger/RKLogger2$Companion;->d(Ljava/lang/String;)V

    return-void
.end method

.method public static final d(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->d(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final debug(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0}, Lcom/rokid/logger/RKLogger2$Companion;->debug(Ljava/lang/String;)V

    return-void
.end method

.method public static final debug(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->debug(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final e(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0}, Lcom/rokid/logger/RKLogger2$Companion;->e(Ljava/lang/String;)V

    return-void
.end method

.method public static final e(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->e(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final error(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0}, Lcom/rokid/logger/RKLogger2$Companion;->error(Ljava/lang/String;)V

    return-void
.end method

.method public static final error(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->error(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final getLogPath()Ljava/lang/String;
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0}, Lcom/rokid/logger/RKLogger2$Companion;->getLogPath()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static final i(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0}, Lcom/rokid/logger/RKLogger2$Companion;->i(Ljava/lang/String;)V

    return-void
.end method

.method public static final i(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->i(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final info(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0}, Lcom/rokid/logger/RKLogger2$Companion;->info(Ljava/lang/String;)V

    return-void
.end method

.method public static final info(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->info(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final initDefaultConfig(Lcom/rokid/logger/manager/LogcatConfig;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0}, Lcom/rokid/logger/RKLogger2$Companion;->initDefaultConfig(Lcom/rokid/logger/manager/LogcatConfig;)V

    return-void
.end method

.method public static final newInstance(Ljava/lang/String;Lcom/rokid/logger/manager/LogcatConfig;)Lcom/rokid/logger/RKLogger2;
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->newInstance(Ljava/lang/String;Lcom/rokid/logger/manager/LogcatConfig;)Lcom/rokid/logger/RKLogger2;

    move-result-object v0

    return-object v0
.end method

.method private final printLog(ILjava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "level"    # I
    .param p2, "tag"    # Ljava/lang/String;
    .param p3, "printLogInfo"    # Ljava/lang/String;

    .line 232
    packed-switch p1, :pswitch_data_0

    .line 237
    invoke-static {p2, p3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 236
    :pswitch_0
    invoke-static {p2, p3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 235
    :pswitch_1
    invoke-static {p2, p3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 234
    :pswitch_2
    invoke-static {p2, p3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 233
    :pswitch_3
    invoke-static {p2, p3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 239
    :goto_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final readyPrintLog(ILjava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "level"    # I
    .param p2, "tag"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;

    .line 213
    iget-object v0, p0, Lcom/rokid/logger/RKLogger2;->mLogcatConfig:Lcom/rokid/logger/manager/LogcatConfig;

    if-nez v0, :cond_1

    .line 214
    if-nez p3, :cond_0

    goto :goto_0

    :cond_0
    move-object v0, p3

    .line 261
    .local v0, "it":Ljava/lang/String;
    const/4 v1, 0x0

    .line 214
    .local v1, "$i$a$-let-RKLogger2$readyPrintLog$1":I
    invoke-direct {p0, p1, p2, v0}, Lcom/rokid/logger/RKLogger2;->printLog(ILjava/lang/String;Ljava/lang/String;)V

    .line 215
    .end local v0    # "it":Ljava/lang/String;
    .end local v1    # "$i$a$-let-RKLogger2$readyPrintLog$1":I
    :goto_0
    return-void

    .line 217
    :cond_1
    iget-object v0, p0, Lcom/rokid/logger/RKLogger2;->mLogcatConfig:Lcom/rokid/logger/manager/LogcatConfig;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0}, Lcom/rokid/logger/manager/LogcatConfig;->getFilterLevel()I

    move-result v0

    if-ge p1, v0, :cond_2

    .line 218
    return-void

    .line 222
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/rokid/logger/RKLogger2;->mLogcatConfig:Lcom/rokid/logger/manager/LogcatConfig;

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v1}, Lcom/rokid/logger/manager/LogcatConfig;->getModule()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x2d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Landroid/os/Process;->myTid()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "  "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 221
    nop

    .line 224
    .local v0, "printLogInfo":Ljava/lang/String;
    iget-object v1, p0, Lcom/rokid/logger/RKLogger2;->logger:Lorg/slf4j/Logger;

    if-eqz v1, :cond_3

    .line 225
    invoke-direct {p0, p1, v0}, Lcom/rokid/logger/RKLogger2;->saveAndPrintLog(ILjava/lang/String;)V

    goto :goto_1

    .line 227
    :cond_3
    invoke-direct {p0, p1, p2, v0}, Lcom/rokid/logger/RKLogger2;->printLog(ILjava/lang/String;Ljava/lang/String;)V

    .line 229
    :goto_1
    return-void
.end method

.method private final saveAndPrintLog(ILjava/lang/String;)V
    .locals 3
    .param p1, "level"    # I
    .param p2, "message"    # Ljava/lang/String;

    .line 248
    sget-object v0, Lcom/rokid/logger/RKLogUploader;->INSTANCE:Lcom/rokid/logger/RKLogUploader;

    invoke-virtual {v0}, Lcom/rokid/logger/RKLogUploader;->getUploadLock()Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    const/4 v1, 0x0

    .line 249
    .local v1, "$i$a$-synchronized-RKLogger2$saveAndPrintLog$1":I
    packed-switch p1, :pswitch_data_0

    .line 255
    :try_start_0
    iget-object v2, p0, Lcom/rokid/logger/RKLogger2;->logger:Lorg/slf4j/Logger;

    goto :goto_5

    .line 254
    :pswitch_0
    iget-object v2, p0, Lcom/rokid/logger/RKLogger2;->logger:Lorg/slf4j/Logger;

    if-nez v2, :cond_0

    :goto_0
    goto :goto_7

    :cond_0
    invoke-interface {v2, p2}, Lorg/slf4j/Logger;->error(Ljava/lang/String;)V

    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    goto :goto_0

    .line 253
    :pswitch_1
    iget-object v2, p0, Lcom/rokid/logger/RKLogger2;->logger:Lorg/slf4j/Logger;

    if-nez v2, :cond_1

    :goto_1
    goto :goto_7

    :cond_1
    invoke-interface {v2, p2}, Lorg/slf4j/Logger;->warn(Ljava/lang/String;)V

    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    goto :goto_1

    .line 252
    :pswitch_2
    iget-object v2, p0, Lcom/rokid/logger/RKLogger2;->logger:Lorg/slf4j/Logger;

    if-nez v2, :cond_2

    :goto_2
    goto :goto_7

    :cond_2
    invoke-interface {v2, p2}, Lorg/slf4j/Logger;->info(Ljava/lang/String;)V

    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    goto :goto_2

    .line 251
    :pswitch_3
    iget-object v2, p0, Lcom/rokid/logger/RKLogger2;->logger:Lorg/slf4j/Logger;

    if-nez v2, :cond_3

    :goto_3
    goto :goto_7

    :cond_3
    invoke-interface {v2, p2}, Lorg/slf4j/Logger;->debug(Ljava/lang/String;)V

    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    goto :goto_3

    .line 250
    :pswitch_4
    iget-object v2, p0, Lcom/rokid/logger/RKLogger2;->logger:Lorg/slf4j/Logger;

    if-nez v2, :cond_4

    :goto_4
    goto :goto_7

    :cond_4
    invoke-interface {v2, p2}, Lorg/slf4j/Logger;->trace(Ljava/lang/String;)V

    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    goto :goto_4

    .line 248
    .end local v1    # "$i$a$-synchronized-RKLogger2$saveAndPrintLog$1":I
    :catchall_0
    move-exception v1

    goto :goto_8

    .line 255
    .restart local v1    # "$i$a$-synchronized-RKLogger2$saveAndPrintLog$1":I
    :goto_5
    if-nez v2, :cond_5

    :goto_6
    goto :goto_7

    :cond_5
    invoke-interface {v2, p2}, Lorg/slf4j/Logger;->trace(Ljava/lang/String;)V

    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_6

    .line 249
    :goto_7
    nop

    .line 248
    .end local v1    # "$i$a$-synchronized-RKLogger2$saveAndPrintLog$1":I
    monitor-exit v0

    .line 258
    return-void

    .line 248
    :goto_8
    monitor-exit v0

    throw v1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final setLogcatConfig(Lcom/rokid/logger/manager/LogcatConfig;)V
    .locals 4
    .param p1, "logcatConfig"    # Lcom/rokid/logger/manager/LogcatConfig;

    .line 165
    iput-object p1, p0, Lcom/rokid/logger/RKLogger2;->mLogcatConfig:Lcom/rokid/logger/manager/LogcatConfig;

    .line 166
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->isSaveLogInfo()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 167
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFilePath()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    move v0, v1

    :goto_1
    if-nez v0, :cond_3

    .line 170
    iget-object v0, p0, Lcom/rokid/logger/RKLogger2;->logger:Lorg/slf4j/Logger;

    if-nez v0, :cond_4

    .line 171
    new-instance v0, Lde/mindpipe/android/logging/log4j/LogConfigurator;

    invoke-direct {v0}, Lde/mindpipe/android/logging/log4j/LogConfigurator;-><init>()V

    .line 172
    .local v0, "logConfigurator":Lde/mindpipe/android/logging/log4j/LogConfigurator;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFilePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x2f

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFileName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lde/mindpipe/android/logging/log4j/LogConfigurator;->setFileName(Ljava/lang/String;)V

    .line 173
    sget-object v2, Lorg/apache/log4j/Level;->TRACE:Lorg/apache/log4j/Level;

    invoke-virtual {v0, v2}, Lde/mindpipe/android/logging/log4j/LogConfigurator;->setRootLevel(Lorg/apache/log4j/Level;)V

    .line 174
    const-string v2, "org.apache"

    sget-object v3, Lorg/apache/log4j/Level;->TRACE:Lorg/apache/log4j/Level;

    invoke-virtual {v0, v2, v3}, Lde/mindpipe/android/logging/log4j/LogConfigurator;->setLevel(Ljava/lang/String;Lorg/apache/log4j/Level;)V

    .line 177
    const-string v2, "%d %-5p [%t] %m%n"

    invoke-virtual {v0, v2}, Lde/mindpipe/android/logging/log4j/LogConfigurator;->setFilePattern(Ljava/lang/String;)V

    .line 178
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFileCacheSize()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Lde/mindpipe/android/logging/log4j/LogConfigurator;->setMaxFileSize(J)V

    .line 179
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFileNum()I

    move-result v2

    invoke-virtual {v0, v2}, Lde/mindpipe/android/logging/log4j/LogConfigurator;->setMaxBackupSize(I)V

    .line 180
    invoke-virtual {v0, v1}, Lde/mindpipe/android/logging/log4j/LogConfigurator;->setImmediateFlush(Z)V

    .line 181
    invoke-virtual {v0}, Lde/mindpipe/android/logging/log4j/LogConfigurator;->configure()V

    .line 182
    iget-object v1, p0, Lcom/rokid/logger/RKLogger2;->mLogcatConfig:Lcom/rokid/logger/manager/LogcatConfig;

    if-nez v1, :cond_2

    const/4 v1, 0x0

    goto :goto_2

    :cond_2
    invoke-virtual {v1}, Lcom/rokid/logger/manager/LogcatConfig;->getModule()Ljava/lang/String;

    move-result-object v1

    :goto_2
    invoke-static {v1}, Lorg/slf4j/LoggerFactory;->getLogger(Ljava/lang/String;)Lorg/slf4j/Logger;

    move-result-object v1

    iput-object v1, p0, Lcom/rokid/logger/RKLogger2;->logger:Lorg/slf4j/Logger;

    goto :goto_3

    .line 168
    .end local v0    # "logConfigurator":Lde/mindpipe/android/logging/log4j/LogConfigurator;
    :cond_3
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "filePath is null or empty, please check your config."

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 185
    :cond_4
    :goto_3
    return-void
.end method

.method public static final v(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0}, Lcom/rokid/logger/RKLogger2$Companion;->v(Ljava/lang/String;)V

    return-void
.end method

.method public static final v(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->v(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final verbose(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0}, Lcom/rokid/logger/RKLogger2$Companion;->verbose(Ljava/lang/String;)V

    return-void
.end method

.method public static final verbose(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->verbose(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final w(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0}, Lcom/rokid/logger/RKLogger2$Companion;->w(Ljava/lang/String;)V

    return-void
.end method

.method public static final w(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->w(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final warning(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0}, Lcom/rokid/logger/RKLogger2$Companion;->warning(Ljava/lang/String;)V

    return-void
.end method

.method public static final warning(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v0, p0, p1}, Lcom/rokid/logger/RKLogger2$Companion;->warning(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public final D(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 197
    const/4 v0, 0x2

    invoke-direct {p0, v0, p1, p2}, Lcom/rokid/logger/RKLogger2;->readyPrintLog(ILjava/lang/String;Ljava/lang/String;)V

    .line 198
    return-void
.end method

.method public final E(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 209
    const/4 v0, 0x5

    invoke-direct {p0, v0, p1, p2}, Lcom/rokid/logger/RKLogger2;->readyPrintLog(ILjava/lang/String;Ljava/lang/String;)V

    .line 210
    return-void
.end method

.method public final I(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 201
    const/4 v0, 0x3

    invoke-direct {p0, v0, p1, p2}, Lcom/rokid/logger/RKLogger2;->readyPrintLog(ILjava/lang/String;Ljava/lang/String;)V

    .line 202
    return-void
.end method

.method public final W(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 205
    const/4 v0, 0x4

    invoke-direct {p0, v0, p1, p2}, Lcom/rokid/logger/RKLogger2;->readyPrintLog(ILjava/lang/String;Ljava/lang/String;)V

    .line 206
    return-void
.end method

.method public final getLogcatConfig()Lcom/rokid/logger/manager/LogcatConfig;
    .locals 1

    .line 188
    iget-object v0, p0, Lcom/rokid/logger/RKLogger2;->mLogcatConfig:Lcom/rokid/logger/manager/LogcatConfig;

    return-object v0
.end method

.method public final verbose1(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 193
    const/4 v0, 0x1

    invoke-direct {p0, v0, p1, p2}, Lcom/rokid/logger/RKLogger2;->readyPrintLog(ILjava/lang/String;Ljava/lang/String;)V

    .line 194
    return-void
.end method
