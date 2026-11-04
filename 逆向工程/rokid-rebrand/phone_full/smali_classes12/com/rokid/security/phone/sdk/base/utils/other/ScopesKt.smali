.class public final Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;
.super Ljava/lang/Object;
.source "Scopes.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nScopes.kt\nKotlin\n*S Kotlin\n*F\n+ 1 Scopes.kt\ncom/rokid/security/phone/sdk/base/utils/other/ScopesKt\n+ 2 CoroutineExceptionHandler.kt\nkotlinx/coroutines/CoroutineExceptionHandlerKt\n*L\n1#1,22:1\n48#2,4:23\n48#2,4:27\n48#2,4:31\n*S KotlinDebug\n*F\n+ 1 Scopes.kt\ncom/rokid/security/phone/sdk/base/utils/other/ScopesKt\n*L\n10#1:23,4\n14#1:27,4\n18#1:31,4\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0007\"\u0011\u0010\u0000\u001a\u00020\u0001\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0002\u0010\u0003\"\u0011\u0010\u0004\u001a\u00020\u0001\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0003\"\u0011\u0010\u0006\u001a\u00020\u0001\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0007\u0010\u0003\u00a8\u0006\u0008"
    }
    d2 = {
        "defaultScope",
        "Lkotlinx/coroutines/CoroutineScope;",
        "getDefaultScope",
        "()Lkotlinx/coroutines/CoroutineScope;",
        "mainScope",
        "getMainScope",
        "workScope",
        "getWorkScope",
        "base-utils_release"
    }
    k = 0x2
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field private static final defaultScope:Lkotlinx/coroutines/CoroutineScope;

.field private static final mainScope:Lkotlinx/coroutines/CoroutineScope;

.field private static final workScope:Lkotlinx/coroutines/CoroutineScope;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .line 10
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-static {v0, v1, v0}, Lkotlinx/coroutines/SupervisorKt;->SupervisorJob$default(Lkotlinx/coroutines/Job;ILjava/lang/Object;)Lkotlinx/coroutines/CompletableJob;

    move-result-object v2

    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v3

    check-cast v3, Lkotlin/coroutines/CoroutineContext;

    invoke-interface {v2, v3}, Lkotlinx/coroutines/CompletableJob;->plus(Lkotlin/coroutines/CoroutineContext;)Lkotlin/coroutines/CoroutineContext;

    move-result-object v2

    const/4 v3, 0x0

    .line 23
    .local v3, "$i$f$CoroutineExceptionHandler":I
    sget-object v4, Lkotlinx/coroutines/CoroutineExceptionHandler;->Key:Lkotlinx/coroutines/CoroutineExceptionHandler$Key;

    new-instance v5, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt$special$$inlined$CoroutineExceptionHandler$1;

    invoke-direct {v5, v4}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt$special$$inlined$CoroutineExceptionHandler$1;-><init>(Lkotlinx/coroutines/CoroutineExceptionHandler$Key;)V

    check-cast v5, Lkotlinx/coroutines/CoroutineExceptionHandler;

    .line 26
    nop

    .end local v3    # "$i$f$CoroutineExceptionHandler":I
    check-cast v5, Lkotlin/coroutines/CoroutineContext;

    .line 10
    invoke-interface {v2, v5}, Lkotlin/coroutines/CoroutineContext;->plus(Lkotlin/coroutines/CoroutineContext;)Lkotlin/coroutines/CoroutineContext;

    move-result-object v2

    invoke-static {v2}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v2

    sput-object v2, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->workScope:Lkotlinx/coroutines/CoroutineScope;

    .line 14
    invoke-static {v0, v1, v0}, Lkotlinx/coroutines/SupervisorKt;->SupervisorJob$default(Lkotlinx/coroutines/Job;ILjava/lang/Object;)Lkotlinx/coroutines/CompletableJob;

    move-result-object v2

    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v3

    check-cast v3, Lkotlin/coroutines/CoroutineContext;

    invoke-interface {v2, v3}, Lkotlinx/coroutines/CompletableJob;->plus(Lkotlin/coroutines/CoroutineContext;)Lkotlin/coroutines/CoroutineContext;

    move-result-object v2

    const/4 v3, 0x0

    .line 27
    .restart local v3    # "$i$f$CoroutineExceptionHandler":I
    sget-object v4, Lkotlinx/coroutines/CoroutineExceptionHandler;->Key:Lkotlinx/coroutines/CoroutineExceptionHandler$Key;

    new-instance v5, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt$special$$inlined$CoroutineExceptionHandler$2;

    invoke-direct {v5, v4}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt$special$$inlined$CoroutineExceptionHandler$2;-><init>(Lkotlinx/coroutines/CoroutineExceptionHandler$Key;)V

    check-cast v5, Lkotlinx/coroutines/CoroutineExceptionHandler;

    .line 30
    nop

    .end local v3    # "$i$f$CoroutineExceptionHandler":I
    check-cast v5, Lkotlin/coroutines/CoroutineContext;

    .line 14
    invoke-interface {v2, v5}, Lkotlin/coroutines/CoroutineContext;->plus(Lkotlin/coroutines/CoroutineContext;)Lkotlin/coroutines/CoroutineContext;

    move-result-object v2

    invoke-static {v2}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v2

    sput-object v2, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->mainScope:Lkotlinx/coroutines/CoroutineScope;

    .line 18
    invoke-static {v0, v1, v0}, Lkotlinx/coroutines/SupervisorKt;->SupervisorJob$default(Lkotlinx/coroutines/Job;ILjava/lang/Object;)Lkotlinx/coroutines/CompletableJob;

    move-result-object v0

    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getDefault()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v1

    check-cast v1, Lkotlin/coroutines/CoroutineContext;

    invoke-interface {v0, v1}, Lkotlinx/coroutines/CompletableJob;->plus(Lkotlin/coroutines/CoroutineContext;)Lkotlin/coroutines/CoroutineContext;

    move-result-object v0

    const/4 v1, 0x0

    .line 31
    .local v1, "$i$f$CoroutineExceptionHandler":I
    sget-object v2, Lkotlinx/coroutines/CoroutineExceptionHandler;->Key:Lkotlinx/coroutines/CoroutineExceptionHandler$Key;

    new-instance v3, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt$special$$inlined$CoroutineExceptionHandler$3;

    invoke-direct {v3, v2}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt$special$$inlined$CoroutineExceptionHandler$3;-><init>(Lkotlinx/coroutines/CoroutineExceptionHandler$Key;)V

    check-cast v3, Lkotlinx/coroutines/CoroutineExceptionHandler;

    .line 34
    nop

    .end local v1    # "$i$f$CoroutineExceptionHandler":I
    check-cast v3, Lkotlin/coroutines/CoroutineContext;

    .line 18
    invoke-interface {v0, v3}, Lkotlin/coroutines/CoroutineContext;->plus(Lkotlin/coroutines/CoroutineContext;)Lkotlin/coroutines/CoroutineContext;

    move-result-object v0

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->defaultScope:Lkotlinx/coroutines/CoroutineScope;

    return-void
.end method

.method public static final getDefaultScope()Lkotlinx/coroutines/CoroutineScope;
    .locals 1

    .line 18
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->defaultScope:Lkotlinx/coroutines/CoroutineScope;

    return-object v0
.end method

.method public static final getMainScope()Lkotlinx/coroutines/CoroutineScope;
    .locals 1

    .line 14
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->mainScope:Lkotlinx/coroutines/CoroutineScope;

    return-object v0
.end method

.method public static final getWorkScope()Lkotlinx/coroutines/CoroutineScope;
    .locals 1

    .line 10
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->workScope:Lkotlinx/coroutines/CoroutineScope;

    return-object v0
.end method
