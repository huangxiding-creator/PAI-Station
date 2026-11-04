.class public final Lcom/rokid/security/phone/sdk/server/asr/ASRRequest;
.super Ljava/lang/Object;
.source "AsrRequest.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J$\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u00082\u0014\u0010\t\u001a\u0010\u0012\u0006\u0012\u0004\u0018\u00010\u000b\u0012\u0004\u0012\u00020\u00060\nR\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000c"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/asr/ASRRequest;",
        "",
        "()V",
        "TAG",
        "",
        "asrInt",
        "",
        "request",
        "Lcom/rokid/security/phone/sdk/server/asr/AsrRequestParam;",
        "callBack",
        "Lkotlin/Function1;",
        "Lcom/rokid/security/phone/sdk/server/asr/AsrIntent;",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/asr/ASRRequest;

.field private static final TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/asr/ASRRequest;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/asr/ASRRequest;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/asr/ASRRequest;->INSTANCE:Lcom/rokid/security/phone/sdk/server/asr/ASRRequest;

    .line 17
    const-string v0, "ASRRequest"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/asr/ASRRequest;->TAG:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 15
    sget-object v0, Lcom/rokid/security/phone/sdk/server/asr/ASRRequest;->TAG:Ljava/lang/String;

    return-object v0
.end method


# virtual methods
.method public final asrInt(Lcom/rokid/security/phone/sdk/server/asr/AsrRequestParam;Lkotlin/jvm/functions/Function1;)V
    .locals 7
    .param p1, "request"    # Lcom/rokid/security/phone/sdk/server/asr/AsrRequestParam;
    .param p2, "callBack"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/asr/AsrRequestParam;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/asr/AsrIntent;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "request"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "callBack"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/asr/ASRRequest$asrInt$1;

    const/4 v2, 0x0

    invoke-direct {v0, p1, p2, v2}, Lcom/rokid/security/phone/sdk/server/asr/ASRRequest$asrInt$1;-><init>(Lcom/rokid/security/phone/sdk/server/asr/AsrRequestParam;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 31
    return-void
.end method
