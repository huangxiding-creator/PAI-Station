.class final Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "BtFileSender.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
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

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBtFileSender.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BtFileSender.kt\ncom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult$Companion\n*L\n1#1,148:1\n93#2:149\n*S KotlinDebug\n*F\n+ 1 BtFileSender.kt\ncom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2\n*L\n110#1:149\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0010\u0002\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u0001*\u00020\u0002H\u008a@"
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
    c = "com.rokid.security.phone.sdk.server.msg.file.BtFileSender$sendFile$2$2"
    f = "BtFileSender.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

.field final synthetic $generation:J

.field final synthetic $onResult:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;JLcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;",
            "J",
            "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    iput-wide p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;->$generation:J

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iput-object p5, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;->$onResult:Lkotlin/jvm/functions/Function1;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p6}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 8
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

    new-instance v7, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    iget-wide v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;->$generation:J

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;->$onResult:Lkotlin/jvm/functions/Function1;

    move-object v0, v7

    move-object v6, p2

    invoke-direct/range {v0 .. v6}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;JLcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V

    check-cast v7, Lkotlin/coroutines/Continuation;

    return-object v7
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 9

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 107
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v0, p0

    .line 108
    .local v0, "this":Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;
    .local p1, "$result":Ljava/lang/Object;
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    iget-wide v2, v0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;->$generation:J

    invoke-static {v1, v2, v3}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$isCurrent(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;J)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 109
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    if-eqz v1, :cond_0

    invoke-interface {v1}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onFail()V

    .line 110
    :cond_0
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;->$onResult:Lkotlin/jvm/functions/Function1;

    sget-object v2, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    new-instance v2, Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    const/4 v7, 0x4

    const/4 v8, 0x0

    const/4 v4, -0x1

    const-string/jumbo v5, "\u53d1\u9001\u5931\u8d25"

    const/4 v6, 0x0

    move-object v3, v2

    invoke-direct/range {v3 .. v8}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .local v2, "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    const/4 v3, 0x0

    .line 149
    .local v3, "$i$f$failure":I
    invoke-static {v2}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultKt;->createFailure(Lcom/rokid/security/phone/sdk/base/data/callback/IException;)Ljava/lang/Object;

    move-result-object v4

    invoke-static {v4}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .end local v2    # "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    .end local v3    # "$i$f$failure":I
    invoke-static {v2}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    move-result-object v2

    .line 110
    invoke-interface {v1, v2}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 112
    :cond_1
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
