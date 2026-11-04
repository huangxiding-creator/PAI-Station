.class public final Lcom/rokid/security/phone/sdk/server/aiwork/AiAssitantRequest;
.super Ljava/lang/Object;
.source "aiworkassistantRequest.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000.\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\"\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u00082\u0012\u0010\t\u001a\u000e\u0012\u0004\u0012\u00020\u000b\u0012\u0004\u0012\u00020\u00060\nJ\u000e\u0010\u000c\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\rR\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000e"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/aiwork/AiAssitantRequest;",
        "",
        "()V",
        "TAG",
        "",
        "aiWorkEnd",
        "",
        "request",
        "Lcom/rokid/security/phone/sdk/server/aiwork/AiWorkAssistantEndRequestParam;",
        "onComplete",
        "Lkotlin/Function1;",
        "",
        "aiwokrBegin",
        "Lcom/rokid/security/phone/sdk/server/aiwork/AiWorkAssistantBeginRequestParam;",
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


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/aiwork/AiAssitantRequest;

.field private static final TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/aiwork/AiAssitantRequest;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/aiwork/AiAssitantRequest;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aiwork/AiAssitantRequest;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aiwork/AiAssitantRequest;

    .line 28
    const-string v0, "AiAssitantRequest"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aiwork/AiAssitantRequest;->TAG:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 26
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aiwork/AiAssitantRequest;->TAG:Ljava/lang/String;

    return-object v0
.end method


# virtual methods
.method public final aiWorkEnd(Lcom/rokid/security/phone/sdk/server/aiwork/AiWorkAssistantEndRequestParam;Lkotlin/jvm/functions/Function1;)V
    .locals 7
    .param p1, "request"    # Lcom/rokid/security/phone/sdk/server/aiwork/AiWorkAssistantEndRequestParam;
    .param p2, "onComplete"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/aiwork/AiWorkAssistantEndRequestParam;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "request"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onComplete"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 43
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/aiwork/AiAssitantRequest$aiWorkEnd$1;

    const/4 v2, 0x0

    invoke-direct {v0, p1, p2, v2}, Lcom/rokid/security/phone/sdk/server/aiwork/AiAssitantRequest$aiWorkEnd$1;-><init>(Lcom/rokid/security/phone/sdk/server/aiwork/AiWorkAssistantEndRequestParam;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 55
    return-void
.end method

.method public final aiwokrBegin(Lcom/rokid/security/phone/sdk/server/aiwork/AiWorkAssistantBeginRequestParam;)V
    .locals 7
    .param p1, "request"    # Lcom/rokid/security/phone/sdk/server/aiwork/AiWorkAssistantBeginRequestParam;

    const-string v0, "request"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 30
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/aiwork/AiAssitantRequest$aiwokrBegin$1;

    const/4 v2, 0x0

    invoke-direct {v0, p1, v2}, Lcom/rokid/security/phone/sdk/server/aiwork/AiAssitantRequest$aiwokrBegin$1;-><init>(Lcom/rokid/security/phone/sdk/server/aiwork/AiWorkAssistantBeginRequestParam;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 40
    return-void
.end method
