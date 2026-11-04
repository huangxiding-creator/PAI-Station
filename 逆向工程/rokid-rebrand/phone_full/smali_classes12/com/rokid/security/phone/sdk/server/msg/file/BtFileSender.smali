.class public final Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;
.super Ljava/lang/Object;
.source "BtFileSender.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000b\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008\u0000\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\r\u001a\u00020\u000eJ\u0010\u0010\u000f\u001a\u00020\u00102\u0006\u0010\u0011\u001a\u00020\u0012H\u0002J\u0006\u0010\u0013\u001a\u00020\u0010J\u0016\u0010\u0014\u001a\u00020\u000e2\u000c\u0010\u0015\u001a\u0008\u0012\u0004\u0012\u00020\u000e0\u0016H\u0002J\u001e\u0010\u0014\u001a\u00020\u000e2\u0006\u0010\u0011\u001a\u00020\u00122\u000c\u0010\u0015\u001a\u0008\u0012\u0004\u0012\u00020\u000e0\u0016H\u0002J\u0006\u0010\u0017\u001a\u00020\u000eJN\u0010\u0018\u001a\u00020\u000e2\u0008\u0010\u0019\u001a\u0004\u0018\u00010\u00042\u0006\u0010\u001a\u001a\u00020\u001b2\u0008\u0010\u001c\u001a\u0004\u0018\u00010\u001d2\'\u0010\u001e\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00100 \u00a2\u0006\u000c\u0008!\u0012\u0008\u0008\"\u0012\u0004\u0008\u0008(#\u0012\u0004\u0012\u00020\u000e0\u001f\u00f8\u0001\u0000R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0007\u001a\u0004\u0018\u00010\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\nX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\u000cX\u0082\u0004\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006$"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;",
        "",
        "()V",
        "TAG",
        "",
        "isSending",
        "Ljava/util/concurrent/atomic/AtomicBoolean;",
        "job",
        "Lkotlinx/coroutines/Job;",
        "mainHandler",
        "Landroid/os/Handler;",
        "transferGeneration",
        "Ljava/util/concurrent/atomic/AtomicLong;",
        "close",
        "",
        "isCurrent",
        "",
        "generation",
        "",
        "isSendingFile",
        "notifyApp",
        "block",
        "Lkotlin/Function0;",
        "resetSendState",
        "sendFile",
        "dir",
        "file",
        "Ljava/io/File;",
        "appListener",
        "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
        "onResult",
        "Lkotlin/Function1;",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResult;",
        "Lkotlin/ParameterName;",
        "name",
        "result",
        "sdk-server_release"
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
.field private final TAG:Ljava/lang/String;

.field private final isSending:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private job:Lkotlinx/coroutines/Job;

.field private final mainHandler:Landroid/os/Handler;

.field private final transferGeneration:Ljava/util/concurrent/atomic/AtomicLong;


# direct methods
.method public static synthetic $r8$lambda$BsFbxaC0NstNRUU25rgjvBkACkA(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;JLkotlin/jvm/functions/Function0;)V
    .locals 0

    invoke-static {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->notifyApp$lambda$0(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;JLkotlin/jvm/functions/Function0;)V

    return-void
.end method

.method public static synthetic $r8$lambda$TqgvG1rP7NlhGaEROKpNSttytJU(Lkotlin/jvm/functions/Function0;)V
    .locals 0

    invoke-static {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->notifyApp$lambda$1(Lkotlin/jvm/functions/Function0;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 25
    const-string v0, "BtFileSender"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->TAG:Ljava/lang/String;

    .line 27
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->mainHandler:Landroid/os/Handler;

    .line 28
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->isSending:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 29
    new-instance v0, Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v1, 0x0

    invoke-direct {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicLong;-><init>(J)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->transferGeneration:Ljava/util/concurrent/atomic/AtomicLong;

    .line 24
    return-void
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    .line 24
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$isCurrent(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;J)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;
    .param p1, "generation"    # J

    .line 24
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->isCurrent(J)Z

    move-result v0

    return v0
.end method

.method public static final synthetic access$isSending$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;)Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    .line 24
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->isSending:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method public static final synthetic access$notifyApp(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;JLkotlin/jvm/functions/Function0;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;
    .param p1, "generation"    # J
    .param p3, "block"    # Lkotlin/jvm/functions/Function0;

    .line 24
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->notifyApp(JLkotlin/jvm/functions/Function0;)V

    return-void
.end method

.method private final isCurrent(J)Z
    .locals 2
    .param p1, "generation"    # J

    .line 119
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->transferGeneration:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    cmp-long v0, v0, p1

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private final notifyApp(JLkotlin/jvm/functions/Function0;)V
    .locals 2
    .param p1, "generation"    # J
    .param p3, "block"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 122
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 123
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->isCurrent(J)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p3}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    goto :goto_0

    .line 125
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->mainHandler:Landroid/os/Handler;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$$ExternalSyntheticLambda1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;JLkotlin/jvm/functions/Function0;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 129
    :cond_1
    :goto_0
    return-void
.end method

.method private final notifyApp(Lkotlin/jvm/functions/Function0;)V
    .locals 2
    .param p1, "block"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 132
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->mainHandler:Landroid/os/Handler;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$$ExternalSyntheticLambda0;-><init>(Lkotlin/jvm/functions/Function0;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 133
    :goto_0
    return-void
.end method

.method private static final notifyApp$lambda$0(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;JLkotlin/jvm/functions/Function0;)V
    .locals 1
    .param p0, "this$0"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;
    .param p1, "$generation"    # J
    .param p3, "$block"    # Lkotlin/jvm/functions/Function0;

    const-string/jumbo v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "$block"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 126
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->isCurrent(J)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p3}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    .line 127
    :cond_0
    return-void
.end method

.method private static final notifyApp$lambda$1(Lkotlin/jvm/functions/Function0;)V
    .locals 1
    .param p0, "$tmp0"    # Lkotlin/jvm/functions/Function0;

    const-string v0, "$tmp0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 132
    invoke-interface {p0}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method public final close()V
    .locals 4

    .line 136
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->transferGeneration:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    .line 137
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->isSending:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 138
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->job:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 139
    :cond_0
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->job:Lkotlinx/coroutines/Job;

    .line 140
    nop

    .line 141
    :try_start_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->stopClassBTFileSend()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 142
    :catch_0
    move-exception v0

    .line 143
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "stop file send failed type="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 145
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->TAG:Ljava/lang/String;

    const-string v1, "close: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 146
    return-void
.end method

.method public final isSendingFile()Z
    .locals 1

    .line 32
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->isSending:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    return v0
.end method

.method public final resetSendState()V
    .locals 2

    .line 36
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->TAG:Ljava/lang/String;

    const-string v1, "resetReceiveState: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 37
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->transferGeneration:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    .line 38
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->isSending:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 39
    return-void
.end method

.method public final sendFile(Ljava/lang/String;Ljava/io/File;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;)V
    .locals 17
    .param p1, "dir"    # Ljava/lang/String;
    .param p2, "file"    # Ljava/io/File;
    .param p3, "appListener"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .param p4, "onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/io/File;",
            "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    move-object/from16 v9, p0

    move-object/from16 v10, p4

    const-string v0, "file"

    move-object/from16 v11, p2

    invoke-static {v11, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onResult"

    invoke-static {v10, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 48
    iget-object v0, v9, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " sendFile  ---- "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual/range {p2 .. p2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "  ---- "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual/range {p2 .. p2}, Ljava/io/File;->length()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ". --- isSending = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, v9, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->isSending:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 49
    iget-object v0, v9, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->isSending:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 50
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, "There is a file being sent. Please try again later."

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 51
    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$1;

    move-object/from16 v12, p3

    invoke-direct {v0, v12, v10}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$1;-><init>(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;)V

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-direct {v9, v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->notifyApp(Lkotlin/jvm/functions/Function0;)V

    .line 55
    return-void

    .line 57
    :cond_0
    move-object/from16 v12, p3

    invoke-virtual/range {p0 .. p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->close()V

    .line 58
    iget-object v0, v9, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->transferGeneration:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    move-result-wide v13

    .line 59
    .local v13, "generation":J
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v15

    new-instance v16, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;

    const/4 v8, 0x0

    move-object/from16 v0, v16

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move-object/from16 v3, p2

    move-wide v4, v13

    move-object/from16 v6, p3

    move-object/from16 v7, p4

    invoke-direct/range {v0 .. v8}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;Ljava/lang/String;Ljava/io/File;JLcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V

    move-object/from16 v3, v16

    check-cast v3, Lkotlin/jvm/functions/Function2;

    const/4 v4, 0x3

    const/4 v5, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    move-object v0, v15

    invoke-static/range {v0 .. v5}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    iput-object v0, v9, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->job:Lkotlinx/coroutines/Job;

    .line 117
    return-void
.end method
