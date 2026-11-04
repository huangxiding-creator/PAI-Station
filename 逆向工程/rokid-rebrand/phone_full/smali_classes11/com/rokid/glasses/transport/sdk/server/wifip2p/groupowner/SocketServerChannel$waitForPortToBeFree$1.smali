.class final Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;
.super Lkotlin/coroutines/jvm/internal/ContinuationImpl;
.source "SocketServerChannel.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->waitForPortToBeFree(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation

.annotation runtime Lkotlin/coroutines/jvm/internal/DebugMetadata;
    c = "com.rokid.glasses.transport.sdk.server.wifip2p.groupowner.SocketServerChannel"
    f = "SocketServerChannel.kt"
    i = {
        0x0,
        0x0,
        0x0
    }
    l = {
        0x97
    }
    m = "waitForPortToBeFree"
    n = {
        "this",
        "timeoutMs",
        "startTime"
    }
    s = {
        "L$0",
        "J$0",
        "J$1"
    }
.end annotation


# instance fields
.field J$0:J

.field J$1:J

.field L$0:Ljava/lang/Object;

.field label:I

.field synthetic result:Ljava/lang/Object;

.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;


# direct methods
.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;Lkotlin/coroutines/Continuation;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-direct {p0, p2}, Lkotlin/coroutines/jvm/internal/ContinuationImpl;-><init>(Lkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 4

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;->result:Ljava/lang/Object;

    iget v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;->label:I

    const/high16 v1, -0x80000000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;->label:I

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    const-wide/16 v1, 0x0

    move-object v3, p0

    check-cast v3, Lkotlin/coroutines/Continuation;

    invoke-static {v0, v1, v2, v3}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$waitForPortToBeFree(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method
