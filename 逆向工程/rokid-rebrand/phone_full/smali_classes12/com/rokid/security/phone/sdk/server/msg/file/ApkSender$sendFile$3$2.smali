.class final Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "ApkSender.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/coroutines/jvm/internal/SuspendLambda;",
        "Lkotlin/jvm/functions/Function2<",
        "Lkotlinx/coroutines/CoroutineScope;",
        "Lkotlin/coroutines/Continuation<",
        "-",
        "Lkotlin/Unit;",
        ">;",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0010\u0002\n\u0002\u0018\u0002\u0010\u0000\u001a\u0004\u0018\u00010\u0001*\u00020\u0002H\u008a@"
    }
    d2 = {
        "<anonymous>",
        "",
        "Lkotlinx/coroutines/CoroutineScope;"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation

.annotation runtime Lkotlin/coroutines/jvm/internal/DebugMetadata;
    c = "com.rokid.security.phone.sdk.server.msg.file.ApkSender$sendFile$3$2"
    f = "ApkSender.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $fileLength:J

.field final synthetic $listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

.field final synthetic $totalTransferred:Lkotlin/jvm/internal/Ref$LongRef;

.field label:I


# direct methods
.method constructor <init>(Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Lkotlin/jvm/internal/Ref$LongRef;JLkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;",
            "Lkotlin/jvm/internal/Ref$LongRef;",
            "J",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;->$listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;->$totalTransferred:Lkotlin/jvm/internal/Ref$LongRef;

    iput-wide p3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;->$fileLength:J

    const/4 v0, 0x2

    invoke-direct {p0, v0, p5}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Lkotlin/coroutines/Continuation<",
            "*>;)",
            "Lkotlin/coroutines/Continuation<",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation

    new-instance v6, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;->$listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;->$totalTransferred:Lkotlin/jvm/internal/Ref$LongRef;

    iget-wide v3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;->$fileLength:J

    move-object v0, v6

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;-><init>(Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Lkotlin/jvm/internal/Ref$LongRef;JLkotlin/coroutines/Continuation;)V

    check-cast v6, Lkotlin/coroutines/Continuation;

    return-object v6
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlinx/coroutines/CoroutineScope;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 6

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 114
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v0, p0

    .line 115
    .local v0, "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;
    .local p1, "$result":Ljava/lang/Object;
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;->$listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    if-eqz v1, :cond_0

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;->$totalTransferred:Lkotlin/jvm/internal/Ref$LongRef;

    iget-wide v2, v2, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    iget-wide v4, v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;->$fileLength:J

    invoke-interface {v1, v2, v3, v4, v5}, Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;->onProgress(JJ)V

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
