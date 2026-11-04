.class final Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "ApkSender.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->connectSocket(Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
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
    c = "com.rokid.security.phone.sdk.server.msg.file.ApkSender$connectSocket$2"
    f = "ApkSender.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $host:Ljava/lang/String;

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;",
            "Ljava/lang/String;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;->$host:Ljava/lang/String;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p3}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 3
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

    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;->$host:Ljava/lang/String;

    invoke-direct {v0, v1, v2, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 9

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 179
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v0, p0

    .line 180
    .local v0, "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;
    .local p1, "$result":Ljava/lang/Object;
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    new-instance v2, Ljava/net/Socket;

    invoke-direct {v2}, Ljava/net/Socket;-><init>()V

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;->$host:Ljava/lang/String;

    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    move-object v5, v2

    .local v5, "$this$invokeSuspend_u24lambda_u240":Ljava/net/Socket;
    const/4 v6, 0x0

    .line 181
    .local v6, "$i$a$-apply-ApkSender$connectSocket$2$1":I
    new-instance v7, Ljava/net/InetSocketAddress;

    invoke-static {v4}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getMPort$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)I

    move-result v8

    invoke-direct {v7, v3, v8}, Ljava/net/InetSocketAddress;-><init>(Ljava/lang/String;I)V

    move-object v3, v7

    .line 182
    .local v3, "socketAddress":Ljava/net/InetSocketAddress;
    move-object v7, v3

    check-cast v7, Ljava/net/SocketAddress;

    invoke-static {v4}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getConnectTimeout$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)I

    move-result v4

    invoke-virtual {v5, v7, v4}, Ljava/net/Socket;->connect(Ljava/net/SocketAddress;I)V

    .line 183
    const/16 v4, 0x4e20

    invoke-virtual {v5, v4}, Ljava/net/Socket;->setSoTimeout(I)V

    .line 184
    nop

    .line 180
    .end local v3    # "socketAddress":Ljava/net/InetSocketAddress;
    .end local v5    # "$this$invokeSuspend_u24lambda_u240":Ljava/net/Socket;
    .end local v6    # "$i$a$-apply-ApkSender$connectSocket$2$1":I
    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$setSocket$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/net/Socket;)V

    .line 185
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getSocket$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)Ljava/net/Socket;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$setOutputStream$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/io/OutputStream;)V

    .line 186
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    new-instance v2, Ljava/io/DataOutputStream;

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getOutputStream$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)Ljava/io/OutputStream;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$setDataOutputStream$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/io/DataOutputStream;)V

    .line 187
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
