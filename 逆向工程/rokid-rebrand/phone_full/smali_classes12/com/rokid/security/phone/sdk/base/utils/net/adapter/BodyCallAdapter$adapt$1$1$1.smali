.class public final Lcom/rokid/security/phone/sdk/base/utils/net/adapter/BodyCallAdapter$adapt$1$1$1;
.super Ljava/lang/Object;
.source "ResponseCallAdapter.kt"

# interfaces
.implements Lretrofit2/Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/base/utils/net/adapter/BodyCallAdapter$adapt$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lretrofit2/Callback<",
        "TT;>;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000%\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0003\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u0008\u0012\u0004\u0012\u00028\u00000\u0001J\u001e\u0010\u0002\u001a\u00020\u00032\u000c\u0010\u0004\u001a\u0008\u0012\u0004\u0012\u00028\u00000\u00052\u0006\u0010\u0006\u001a\u00020\u0007H\u0016J$\u0010\u0008\u001a\u00020\u00032\u000c\u0010\u0004\u001a\u0008\u0012\u0004\u0012\u00028\u00000\u00052\u000c\u0010\t\u001a\u0008\u0012\u0004\u0012\u00028\u00000\nH\u0016\u00a8\u0006\u000b"
    }
    d2 = {
        "com/rokid/security/phone/sdk/base/utils/net/adapter/BodyCallAdapter$adapt$1$1$1",
        "Lretrofit2/Callback;",
        "onFailure",
        "",
        "call",
        "Lretrofit2/Call;",
        "t",
        "",
        "onResponse",
        "response",
        "Lretrofit2/Response;",
        "base-utils_release"
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
.field final synthetic $continuation:Lkotlinx/coroutines/CancellableContinuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlinx/coroutines/CancellableContinuation<",
            "TT;>;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Lkotlinx/coroutines/CancellableContinuation;)V
    .locals 0
    .param p1, "$continuation"    # Lkotlinx/coroutines/CancellableContinuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlinx/coroutines/CancellableContinuation<",
            "-TT;>;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/BodyCallAdapter$adapt$1$1$1;->$continuation:Lkotlinx/coroutines/CancellableContinuation;

    .line 53
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Lretrofit2/Call;Ljava/lang/Throwable;)V
    .locals 2
    .param p1, "call"    # Lretrofit2/Call;
    .param p2, "t"    # Ljava/lang/Throwable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lretrofit2/Call<",
            "TT;>;",
            "Ljava/lang/Throwable;",
            ")V"
        }
    .end annotation

    const-string v0, "call"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "t"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 55
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/BodyCallAdapter$adapt$1$1$1;->$continuation:Lkotlinx/coroutines/CancellableContinuation;

    check-cast v0, Lkotlin/coroutines/Continuation;

    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {p2}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, v1}, Lkotlin/coroutines/Continuation;->resumeWith(Ljava/lang/Object;)V

    .line 56
    return-void
.end method

.method public onResponse(Lretrofit2/Call;Lretrofit2/Response;)V
    .locals 6
    .param p1, "call"    # Lretrofit2/Call;
    .param p2, "response"    # Lretrofit2/Response;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lretrofit2/Call<",
            "TT;>;",
            "Lretrofit2/Response<",
            "TT;>;)V"
        }
    .end annotation

    const-string v0, "call"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "response"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 59
    nop

    .line 60
    :try_start_0
    invoke-virtual {p2}, Lretrofit2/Response;->isSuccessful()Z

    move-result v0

    if-eqz v0, :cond_7

    .line 61
    invoke-virtual {p2}, Lretrofit2/Response;->body()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_6

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/BodyCallAdapter$adapt$1$1$1;->$continuation:Lkotlinx/coroutines/CancellableContinuation;

    .local v0, "body":Ljava/lang/Object;
    const/4 v2, 0x0

    .line 62
    .local v2, "$i$a$-let-BodyCallAdapter$adapt$1$1$1$onResponse$1":I
    instance-of v3, v0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;

    if-eqz v3, :cond_2

    .line 63
    move-object v3, v0

    check-cast v3, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;->getCode()Ljava/lang/Integer;

    move-result-object v3

    .line 64
    if-nez v3, :cond_1

    :cond_0
    goto :goto_0

    :cond_1
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    const/4 v4, 0x1

    if-ne v3, v4, :cond_0

    .line 65
    check-cast v1, Lkotlin/coroutines/Continuation;

    sget-object v3, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v1, v3}, Lkotlin/coroutines/Continuation;->resumeWith(Ljava/lang/Object;)V

    goto/16 :goto_2

    .line 68
    :goto_0
    check-cast v1, Lkotlin/coroutines/Continuation;

    sget-object v3, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    .line 69
    new-instance v3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;

    .line 70
    move-object v4, v0

    check-cast v4, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;->getCode()Ljava/lang/Integer;

    move-result-object v4

    .line 71
    move-object v5, v0

    check-cast v5, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;

    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;->getMsg()Ljava/lang/String;

    move-result-object v5

    .line 69
    invoke-direct {v3, v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;-><init>(Ljava/lang/Integer;Ljava/lang/String;)V

    check-cast v3, Ljava/lang/Throwable;

    invoke-static {v3}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v1, v3}, Lkotlin/coroutines/Continuation;->resumeWith(Ljava/lang/Object;)V

    goto :goto_2

    .line 77
    :cond_2
    instance-of v3, v0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;

    if-eqz v3, :cond_5

    .line 78
    move-object v3, v0

    check-cast v3, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;->getCode()Ljava/lang/Integer;

    move-result-object v3

    .line 79
    if-nez v3, :cond_4

    :cond_3
    goto :goto_1

    :cond_4
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    if-nez v3, :cond_3

    .line 80
    check-cast v1, Lkotlin/coroutines/Continuation;

    sget-object v3, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v1, v3}, Lkotlin/coroutines/Continuation;->resumeWith(Ljava/lang/Object;)V

    goto :goto_2

    .line 83
    :goto_1
    check-cast v1, Lkotlin/coroutines/Continuation;

    sget-object v3, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    .line 84
    new-instance v3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;

    .line 85
    move-object v4, v0

    check-cast v4, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;->getCode()Ljava/lang/Integer;

    move-result-object v4

    .line 86
    move-object v5, v0

    check-cast v5, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;

    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;->getMsg()Ljava/lang/String;

    move-result-object v5

    .line 84
    invoke-direct {v3, v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;-><init>(Ljava/lang/Integer;Ljava/lang/String;)V

    check-cast v3, Ljava/lang/Throwable;

    invoke-static {v3}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v1, v3}, Lkotlin/coroutines/Continuation;->resumeWith(Ljava/lang/Object;)V

    goto :goto_2

    .line 93
    :cond_5
    check-cast v1, Lkotlin/coroutines/Continuation;

    sget-object v3, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v1, v3}, Lkotlin/coroutines/Continuation;->resumeWith(Ljava/lang/Object;)V

    .line 95
    :goto_2
    return-void

    .line 97
    .end local v0    # "body":Ljava/lang/Object;
    .end local v2    # "$i$a$-let-BodyCallAdapter$adapt$1$1$1$onResponse$1":I
    :cond_6
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/BodyCallAdapter$adapt$1$1$1;->$continuation:Lkotlinx/coroutines/CancellableContinuation;

    check-cast v0, Lkotlin/coroutines/Continuation;

    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    .line 98
    new-instance v1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;

    .line 99
    const/16 v2, -0x3e8

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    .line 100
    const-string/jumbo v3, "\u63a5\u53e3\u8fd4\u56de\u6570\u636e\u4e3a\u7a7a"

    .line 98
    invoke-direct {v1, v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;-><init>(Ljava/lang/Integer;Ljava/lang/String;)V

    check-cast v1, Ljava/lang/Throwable;

    invoke-static {v1}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, v1}, Lkotlin/coroutines/Continuation;->resumeWith(Ljava/lang/Object;)V

    goto :goto_3

    .line 106
    :cond_7
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/BodyCallAdapter$adapt$1$1$1;->$continuation:Lkotlinx/coroutines/CancellableContinuation;

    check-cast v0, Lkotlin/coroutines/Continuation;

    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    new-instance v1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/HttpException;

    invoke-virtual {p2}, Lretrofit2/Response;->code()I

    move-result v2

    invoke-direct {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/HttpException;-><init>(I)V

    check-cast v1, Ljava/lang/Throwable;

    invoke-static {v1}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, v1}, Lkotlin/coroutines/Continuation;->resumeWith(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_3

    .line 108
    :catch_0
    move-exception v0

    .line 109
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 110
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/BodyCallAdapter$adapt$1$1$1;->$continuation:Lkotlinx/coroutines/CancellableContinuation;

    check-cast v1, Lkotlin/coroutines/Continuation;

    sget-object v2, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    .line 111
    new-instance v2, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;

    const/16 v3, -0x3e9

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "\u6570\u636e\u89e3\u6790\u5931\u8d25: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;-><init>(Ljava/lang/Integer;Ljava/lang/String;)V

    check-cast v2, Ljava/lang/Throwable;

    invoke-static {v2}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v1, v2}, Lkotlin/coroutines/Continuation;->resumeWith(Ljava/lang/Object;)V

    .line 115
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_3
    return-void
.end method
