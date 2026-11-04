.class public final Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;
.super Ljava/lang/Object;
.source "ReconnectBackoff.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0002\u0008\u0000\u0018\u0000 \r2\u00020\u0001:\u0001\rB/\u0012\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u0003\u0012\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u0003\u0012\u0014\u0008\u0002\u0010\u0005\u001a\u000e\u0012\u0004\u0012\u00020\u0003\u0012\u0004\u0012\u00020\u00030\u0006\u00a2\u0006\u0002\u0010\u0007J\u0006\u0010\n\u001a\u00020\u0003J\u0006\u0010\u000b\u001a\u00020\u000cR\u000e\u0010\u0008\u001a\u00020\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u0005\u001a\u000e\u0012\u0004\u0012\u00020\u0003\u0012\u0004\u0012\u00020\u00030\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0004\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000e"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;",
        "",
        "initialDelayMs",
        "",
        "maxDelayMs",
        "jitter",
        "Lkotlin/Function1;",
        "(JJLkotlin/jvm/functions/Function1;)V",
        "attempt",
        "",
        "nextDelayMs",
        "reset",
        "",
        "Companion",
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


# static fields
.field private static final Companion:Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff$Companion;

.field public static final JITTER_DIVISOR:J = 0x5L
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final MAX_SHIFT:I = 0x1e
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field


# instance fields
.field private attempt:I

.field private final initialDelayMs:J

.field private final jitter:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/Long;",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation
.end field

.field private final maxDelayMs:J


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->Companion:Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff$Companion;

    return-void
.end method

.method public constructor <init>()V
    .locals 8

    const/4 v6, 0x7

    const/4 v7, 0x0

    const-wide/16 v1, 0x0

    const-wide/16 v3, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    invoke-direct/range {v0 .. v7}, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;-><init>(JJLkotlin/jvm/functions/Function1;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-void
.end method

.method public constructor <init>(JJLkotlin/jvm/functions/Function1;)V
    .locals 1
    .param p1, "initialDelayMs"    # J
    .param p3, "maxDelayMs"    # J
    .param p5, "jitter"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(JJ",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Long;",
            "Ljava/lang/Long;",
            ">;)V"
        }
    .end annotation

    const-string v0, "jitter"

    invoke-static {p5, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 7
    iput-wide p1, p0, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->initialDelayMs:J

    .line 8
    iput-wide p3, p0, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->maxDelayMs:J

    .line 9
    iput-object p5, p0, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->jitter:Lkotlin/jvm/functions/Function1;

    .line 6
    return-void
.end method

.method public synthetic constructor <init>(JJLkotlin/jvm/functions/Function1;ILkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 6

    .line 6
    and-int/lit8 p7, p6, 0x1

    if-eqz p7, :cond_0

    .line 7
    const-wide/16 p1, 0x3e8

    move-wide v1, p1

    goto :goto_0

    .line 6
    :cond_0
    move-wide v1, p1

    :goto_0
    and-int/lit8 p1, p6, 0x2

    if-eqz p1, :cond_1

    .line 8
    const-wide/16 p3, 0x7530

    move-wide v3, p3

    goto :goto_1

    .line 6
    :cond_1
    move-wide v3, p3

    :goto_1
    and-int/lit8 p1, p6, 0x4

    if-eqz p1, :cond_2

    .line 9
    sget-object p1, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff$1;->INSTANCE:Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff$1;

    move-object p5, p1

    check-cast p5, Lkotlin/jvm/functions/Function1;

    move-object v5, p5

    goto :goto_2

    .line 6
    :cond_2
    move-object v5, p5

    :goto_2
    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;-><init>(JJLkotlin/jvm/functions/Function1;)V

    .line 38
    return-void
.end method


# virtual methods
.method public final declared-synchronized nextDelayMs()J
    .locals 17

    move-object/from16 v1, p0

    monitor-enter p0

    .line 17
    :try_start_0
    iget v0, v1, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->attempt:I

    const/16 v2, 0x1e

    invoke-static {v0, v2}, Lkotlin/ranges/RangesKt;->coerceAtMost(II)I

    move-result v0

    .line 18
    .local v0, "shift":I
    const-wide/16 v3, 0x1

    shl-long/2addr v3, v0

    .line 19
    .local v3, "multiplier":J
    iget-wide v5, v1, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->initialDelayMs:J

    iget-wide v7, v1, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->maxDelayMs:J

    div-long/2addr v7, v3

    cmp-long v5, v5, v7

    if-lez v5, :cond_0

    .line 20
    iget-wide v5, v1, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->maxDelayMs:J

    goto :goto_0

    .line 22
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;
    :cond_0
    iget-wide v5, v1, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->initialDelayMs:J

    mul-long/2addr v5, v3

    iget-wide v7, v1, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->maxDelayMs:J

    invoke-static {v5, v6, v7, v8}, Lkotlin/ranges/RangesKt;->coerceAtMost(JJ)J

    move-result-wide v5

    .line 19
    :goto_0
    nop

    .line 24
    .local v5, "baseDelay":J
    iget v7, v1, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->attempt:I

    add-int/lit8 v7, v7, 0x1

    invoke-static {v7, v2}, Lkotlin/ranges/RangesKt;->coerceAtMost(II)I

    move-result v2

    iput v2, v1, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->attempt:I

    .line 25
    const-wide/16 v7, 0x5

    div-long v7, v5, v7

    .line 26
    .local v7, "jitterRange":J
    iget-object v2, v1, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->jitter:Lkotlin/jvm/functions/Function1;

    invoke-static {v7, v8}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v9

    invoke-interface {v2, v9}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Number;

    invoke-virtual {v2}, Ljava/lang/Number;->longValue()J

    move-result-wide v9

    add-long v11, v5, v9

    iget-wide v13, v1, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->initialDelayMs:J

    iget-wide v9, v1, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->maxDelayMs:J

    move-wide v15, v9

    invoke-static/range {v11 .. v16}, Lkotlin/ranges/RangesKt;->coerceIn(JJJ)J

    move-result-wide v9
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-wide v9

    .line 16
    .end local v0    # "shift":I
    .end local v3    # "multiplier":J
    .end local v5    # "baseDelay":J
    .end local v7    # "jitterRange":J
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized reset()V
    .locals 1

    monitor-enter p0

    .line 31
    const/4 v0, 0x0

    :try_start_0
    iput v0, p0, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->attempt:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 32
    monitor-exit p0

    return-void

    .line 30
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
