.class final Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call4$5;
.super Ljava/lang/Object;
.source "ApiException2.kt"

# interfaces
.implements Lkotlinx/coroutines/flow/FlowCollector;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt;->api2Call4(Lkotlin/jvm/functions/Function0;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;",
        "Lkotlinx/coroutines/flow/FlowCollector;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nApiException2.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ApiException2.kt\ncom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call4$5\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult$Companion\n*L\n1#1,322:1\n84#2:323\n93#2:324\n*S KotlinDebug\n*F\n+ 1 ApiException2.kt\ncom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call4$5\n*L\n183#1:323\n194#1:324\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0012\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0010\u0000\u001a\u00020\u0001\"\u0004\u0008\u0000\u0010\u00022\u000c\u0010\u0003\u001a\u0008\u0012\u0004\u0012\u0002H\u00020\u0004H\u008a@\u00a2\u0006\u0004\u0008\u0005\u0010\u0006"
    }
    d2 = {
        "<anonymous>",
        "",
        "T",
        "it",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;",
        "emit",
        "(Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic $message:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $result:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "TT;>;>;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "TT;>;>;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call4$5;->$message:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call4$5;->$result:Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final emit(Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 9
    .param p1, "it"    # Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "TT;>;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 181
    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;->success()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 182
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call4$5;->$message:Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;->getMessage()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 183
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call4$5;->$result:Lkotlin/jvm/internal/Ref$ObjectRef;

    sget-object v1, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    .local v1, "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;->getData()Ljava/lang/Object;

    move-result-object v2

    .local v2, "value$iv":Ljava/lang/Object;
    const/4 v3, 0x0

    .line 323
    .local v3, "$i$f$success":I
    invoke-static {v2}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 183
    .end local v1    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    .end local v2    # "value$iv":Ljava/lang/Object;
    .end local v3    # "$i$f$success":I
    iput-object v1, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    goto :goto_3

    .line 190
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call4$5;->$message:Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;->getMessage()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 191
    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;->getCode()Ljava/lang/Integer;

    move-result-object v0

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/16 v1, 0x2712

    if-eq v0, v1, :cond_3

    :goto_0
    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;->getCode()Ljava/lang/Integer;

    move-result-object v0

    if-nez v0, :cond_2

    goto :goto_1

    :cond_2
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    .line 194
    :cond_3
    :goto_1
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call4$5;->$result:Lkotlin/jvm/internal/Ref$ObjectRef;

    sget-object v1, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    new-instance v8, Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;->getCode()Ljava/lang/Integer;

    move-result-object v2

    if-eqz v2, :cond_4

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    goto :goto_2

    :cond_4
    const/4 v2, -0x1

    :goto_2
    move v3, v2

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;->getMsg()Ljava/lang/String;

    move-result-object v4

    const/4 v6, 0x4

    const/4 v7, 0x0

    const/4 v5, 0x0

    move-object v2, v8

    invoke-direct/range {v2 .. v7}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .restart local v1    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    .local v2, "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    const/4 v3, 0x0

    .line 324
    .local v3, "$i$f$failure":I
    invoke-static {v2}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultKt;->createFailure(Lcom/rokid/security/phone/sdk/base/data/callback/IException;)Ljava/lang/Object;

    move-result-object v4

    invoke-static {v4}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 194
    .end local v1    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    .end local v2    # "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    .end local v3    # "$i$f$failure":I
    iput-object v1, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 196
    :goto_3
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public bridge synthetic emit(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p1, "value"    # Ljava/lang/Object;
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 180
    move-object v0, p1

    check-cast v0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;

    invoke-virtual {p0, v0, p2}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call4$5;->emit(Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method
