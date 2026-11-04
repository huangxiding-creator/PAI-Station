.class public final Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt;
.super Ljava/lang/Object;
.source "OtaDownloadDelivery.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nOtaDownloadDelivery.kt\nKotlin\n*S Kotlin\n*F\n+ 1 OtaDownloadDelivery.kt\ncom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt\n+ 2 CoroutineScope.kt\nkotlinx/coroutines/CoroutineScopeKt\n*L\n1#1,44:1\n329#2:45\n*S KotlinDebug\n*F\n+ 1 OtaDownloadDelivery.kt\ncom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt\n*L\n26#1:45\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\"\n\u0000\n\u0002\u0010\u0003\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0004\u001aC\u0010\u0000\u001a\u0004\u0018\u00010\u00012\u0006\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u00072\n\u0008\u0002\u0010\u0008\u001a\u0004\u0018\u00010\t2\n\u0008\u0002\u0010\n\u001a\u0004\u0018\u00010\tH\u0080@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\u000b\u001a\u0018\u0010\u000c\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\tH\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006\r"
    }
    d2 = {
        "deliverDownloadResult",
        "",
        "dispatcher",
        "Lkotlinx/coroutines/CoroutineDispatcher;",
        "listener",
        "Lcom/rokid/security/phone/sdk/api/base/DownloadListener;",
        "status",
        "",
        "downloaded",
        "",
        "total",
        "(Lkotlinx/coroutines/CoroutineDispatcher;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "streamingProgress",
        "sdk-server_release"
    }
    k = 0x2
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public static final deliverDownloadResult(Lkotlinx/coroutines/CoroutineDispatcher;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 8
    .param p0, "dispatcher"    # Lkotlinx/coroutines/CoroutineDispatcher;
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .param p2, "status"    # I
    .param p3, "downloaded"    # Ljava/lang/Long;
    .param p4, "total"    # Ljava/lang/Long;
    .param p5, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlinx/coroutines/CoroutineDispatcher;",
            "Lcom/rokid/security/phone/sdk/api/base/DownloadListener;",
            "I",
            "Ljava/lang/Long;",
            "Ljava/lang/Long;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Ljava/lang/Throwable;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 26
    const/4 v0, 0x0

    .line 45
    .local v0, "$i$f$currentCoroutineContext":I
    invoke-interface {p5}, Lkotlin/coroutines/Continuation;->getContext()Lkotlin/coroutines/CoroutineContext;

    move-result-object v1

    .line 26
    .end local v0    # "$i$f$currentCoroutineContext":I
    invoke-static {v1}, Lkotlinx/coroutines/JobKt;->ensureActive(Lkotlin/coroutines/CoroutineContext;)V

    .line 27
    move-object v0, p0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v7, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;

    const/4 v6, 0x0

    move-object v1, v7

    move v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p1

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;-><init>(ILjava/lang/Long;Ljava/lang/Long;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;Lkotlin/coroutines/Continuation;)V

    check-cast v7, Lkotlin/jvm/functions/Function2;

    invoke-static {v0, v7, p5}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static synthetic deliverDownloadResult$default(Lkotlinx/coroutines/CoroutineDispatcher;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;ILjava/lang/Object;)Ljava/lang/Object;
    .locals 7

    .line 19
    and-int/lit8 p7, p6, 0x8

    const/4 v0, 0x0

    if-eqz p7, :cond_0

    .line 23
    move-object v4, v0

    goto :goto_0

    .line 19
    :cond_0
    move-object v4, p3

    :goto_0
    and-int/lit8 p3, p6, 0x10

    if-eqz p3, :cond_1

    .line 24
    move-object v5, v0

    goto :goto_1

    .line 19
    :cond_1
    move-object v5, p4

    :goto_1
    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move-object v6, p5

    invoke-static/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt;->deliverDownloadResult(Lkotlinx/coroutines/CoroutineDispatcher;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method public static final streamingProgress(JJ)I
    .locals 4
    .param p0, "downloaded"    # J
    .param p2, "total"    # J

    .line 11
    const-wide/16 v0, 0x0

    cmp-long v0, p2, v0

    const/4 v1, 0x0

    if-gtz v0, :cond_0

    return v1

    .line 12
    :cond_0
    const-wide/16 v2, 0x64

    mul-long/2addr v2, p0

    div-long/2addr v2, p2

    long-to-int v0, v2

    const/16 v2, 0x63

    invoke-static {v0, v1, v2}, Lkotlin/ranges/RangesKt;->coerceIn(III)I

    move-result v0

    return v0
.end method
