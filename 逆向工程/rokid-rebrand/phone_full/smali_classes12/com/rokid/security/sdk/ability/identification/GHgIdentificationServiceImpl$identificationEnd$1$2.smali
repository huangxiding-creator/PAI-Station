.class final Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$identificationEnd$1$2;
.super Ljava/lang/Object;
.source "GHgIdentificationServiceImpl.kt"

# interfaces
.implements Lkotlinx/coroutines/flow/FlowCollector;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$identificationEnd$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
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

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\u0010\u0000\u001a\u00020\u00012\u000c\u0010\u0002\u001a\u0008\u0012\u0004\u0012\u00020\u00040\u0003H\u008a@\u00a2\u0006\u0004\u0008\u0005\u0010\u0006"
    }
    d2 = {
        "<anonymous>",
        "",
        "response",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;",
        "",
        "emit",
        "(Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$identificationEnd$1$2;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$identificationEnd$1$2<",
            "TT;>;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$identificationEnd$1$2;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$identificationEnd$1$2;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$identificationEnd$1$2;->INSTANCE:Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$identificationEnd$1$2;

    return-void
.end method

.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final emit(Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 3
    .param p1, "response"    # Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 241
    invoke-static {}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "identificationEnd complete hasData="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v2

    if-eqz v2, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 242
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public bridge synthetic emit(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p1, "value"    # Ljava/lang/Object;
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 240
    move-object v0, p1

    check-cast v0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;

    invoke-virtual {p0, v0, p2}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$identificationEnd$1$2;->emit(Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method
