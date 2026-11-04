.class final Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "FileSender.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
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
    c = "com.rokid.security.phone.sdk.server.msg.file.FileSender$sendFile$2$2$4"
    f = "FileSender.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

.field final synthetic $currentProgress:F

.field final synthetic $fileLength:J

.field final synthetic $totalBytesRead:Lkotlin/jvm/internal/Ref$LongRef;

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;FLcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/internal/Ref$LongRef;JLkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;",
            "F",
            "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
            "Lkotlin/jvm/internal/Ref$LongRef;",
            "J",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    iput p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->$currentProgress:F

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->$totalBytesRead:Lkotlin/jvm/internal/Ref$LongRef;

    iput-wide p5, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->$fileLength:J

    const/4 v0, 0x2

    invoke-direct {p0, v0, p7}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 9
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

    new-instance v8, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->$currentProgress:F

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->$totalBytesRead:Lkotlin/jvm/internal/Ref$LongRef;

    iget-wide v5, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->$fileLength:J

    move-object v0, v8

    move-object v7, p2

    invoke-direct/range {v0 .. v7}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;FLcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/internal/Ref$LongRef;JLkotlin/coroutines/Continuation;)V

    check-cast v8, Lkotlin/coroutines/Continuation;

    return-object v8
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 9

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 109
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v0, p0

    .line 110
    .local v0, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;
    .local p1, "$result":Ljava/lang/Object;
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " onProgressChanged progress = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->$currentProgress:F

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 111
    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    if-eqz v3, :cond_0

    iget v4, v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->$currentProgress:F

    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->$totalBytesRead:Lkotlin/jvm/internal/Ref$LongRef;

    iget-wide v5, v1, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    iget-wide v7, v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;->$fileLength:J

    invoke-interface/range {v3 .. v8}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onProgressChanged(FJJ)V

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
