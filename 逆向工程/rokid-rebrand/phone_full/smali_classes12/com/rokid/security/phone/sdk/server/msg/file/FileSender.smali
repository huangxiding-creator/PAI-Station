.class public final Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
.super Ljava/lang/Object;
.source "FileSender.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nFileSender.kt\nKotlin\n*S Kotlin\n*F\n+ 1 FileSender.kt\ncom/rokid/security/phone/sdk/server/msg/file/FileSender\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,204:1\n1#2:205\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000v\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0007\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0007\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\u0008\u0000\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0014\u001a\u00020\u0015JO\u0010\u0016\u001a\u00020\u00172\u0006\u0010\u0018\u001a\u00020\u00042\u0008\u0010\u0019\u001a\u0004\u0018\u00010\u001a2\'\u0010\u001b\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00170\u001d\u00a2\u0006\u000c\u0008\u001e\u0012\u0008\u0008\u001f\u0012\u0004\u0008\u0008( \u0012\u0004\u0012\u00020\u00150\u001cH\u0082@\u00f8\u0001\u0000\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010!J\u0006\u0010\"\u001a\u00020\u0015J\u0006\u0010#\u001a\u00020\u0017J\u0016\u0010$\u001a\u00020\u00152\u000c\u0010%\u001a\u0008\u0012\u0004\u0012\u00020\u00150&H\u0002J\u0010\u0010\'\u001a\u00020(2\u0006\u0010)\u001a\u00020(H\u0002JV\u0010*\u001a\u00020\u00152\u0006\u0010\u0018\u001a\u00020\u00042\u0008\u0010+\u001a\u0004\u0018\u00010\u00042\u0006\u0010,\u001a\u00020-2\u0008\u0010\u0019\u001a\u0004\u0018\u00010\u001a2\'\u0010\u001b\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00170\u001d\u00a2\u0006\u000c\u0008\u001e\u0012\u0008\u0008\u001f\u0012\u0004\u0008\u0008( \u0012\u0004\u0012\u00020\u00150\u001c\u00f8\u0001\u0000R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082D\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0007\u001a\u0004\u0018\u00010\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\t\u001a\u0004\u0018\u00010\nX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\rX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000e\u001a\u0004\u0018\u00010\u000fX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0010\u001a\u00020\u0011X\u0082D\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0012\u001a\u0004\u0018\u00010\u0013X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006."
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;",
        "",
        "()V",
        "TAG",
        "",
        "connectTimeout",
        "",
        "dataOutputStream",
        "Ljava/io/DataOutputStream;",
        "job",
        "Lkotlinx/coroutines/Job;",
        "mPort",
        "mainHandler",
        "Landroid/os/Handler;",
        "outputStream",
        "Ljava/io/OutputStream;",
        "progressUpdateThreshold",
        "",
        "socket",
        "Ljava/net/Socket;",
        "close",
        "",
        "connectSocket",
        "",
        "host",
        "appListener",
        "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
        "onResult",
        "Lkotlin/Function1;",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResult;",
        "Lkotlin/ParameterName;",
        "name",
        "result",
        "(Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "disconnectSocket",
        "isSendingFile",
        "notifyMain",
        "block",
        "Lkotlin/Function0;",
        "readResumeOffset",
        "",
        "fileLength",
        "sendFile",
        "dir",
        "file",
        "Ljava/io/File;",
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


# instance fields
.field private final TAG:Ljava/lang/String;

.field private final connectTimeout:I

.field private dataOutputStream:Ljava/io/DataOutputStream;

.field private job:Lkotlinx/coroutines/Job;

.field private mPort:I

.field private final mainHandler:Landroid/os/Handler;

.field private outputStream:Ljava/io/OutputStream;

.field private final progressUpdateThreshold:F

.field private socket:Ljava/net/Socket;


# direct methods
.method public static synthetic $r8$lambda$mI1mQ1MRKI8mfyQqPxpnbrmoO6c(Lkotlin/jvm/functions/Function0;)V
    .locals 0

    invoke-static {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->notifyMain$lambda$1(Lkotlin/jvm/functions/Function0;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 31
    const-string v0, "FileSender"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->TAG:Ljava/lang/String;

    .line 32
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->mainHandler:Landroid/os/Handler;

    .line 33
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getP2pFileSendPort()I

    move-result v0

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->mPort:I

    .line 38
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->progressUpdateThreshold:F

    .line 39
    const/16 v0, 0x1388

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->connectTimeout:I

    .line 30
    return-void
.end method

.method public static final synthetic access$connectSocket(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    .param p1, "host"    # Ljava/lang/String;
    .param p2, "appListener"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .param p3, "onResult"    # Lkotlin/jvm/functions/Function1;
    .param p4, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 30
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->connectSocket(Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getConnectTimeout$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;)I
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    .line 30
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->connectTimeout:I

    return v0
.end method

.method public static final synthetic access$getDataOutputStream$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;)Ljava/io/DataOutputStream;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    .line 30
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->dataOutputStream:Ljava/io/DataOutputStream;

    return-object v0
.end method

.method public static final synthetic access$getMPort$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;)I
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    .line 30
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->mPort:I

    return v0
.end method

.method public static final synthetic access$getOutputStream$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;)Ljava/io/OutputStream;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    .line 30
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->outputStream:Ljava/io/OutputStream;

    return-object v0
.end method

.method public static final synthetic access$getProgressUpdateThreshold$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;)F
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    .line 30
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->progressUpdateThreshold:F

    return v0
.end method

.method public static final synthetic access$getSocket$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;)Ljava/net/Socket;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    .line 30
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->socket:Ljava/net/Socket;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    .line 30
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$readResumeOffset(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;J)J
    .locals 2
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    .param p1, "fileLength"    # J

    .line 30
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->readResumeOffset(J)J

    move-result-wide v0

    return-wide v0
.end method

.method public static final synthetic access$setDataOutputStream$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;Ljava/io/DataOutputStream;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    .param p1, "<set-?>"    # Ljava/io/DataOutputStream;

    .line 30
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->dataOutputStream:Ljava/io/DataOutputStream;

    return-void
.end method

.method public static final synthetic access$setMPort$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;I)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    .param p1, "<set-?>"    # I

    .line 30
    iput p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->mPort:I

    return-void
.end method

.method public static final synthetic access$setOutputStream$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;Ljava/io/OutputStream;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    .param p1, "<set-?>"    # Ljava/io/OutputStream;

    .line 30
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->outputStream:Ljava/io/OutputStream;

    return-void
.end method

.method public static final synthetic access$setSocket$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;Ljava/net/Socket;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    .param p1, "<set-?>"    # Ljava/net/Socket;

    .line 30
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->socket:Ljava/net/Socket;

    return-void
.end method

.method private final connectSocket(Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
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
            "Ljava/lang/Boolean;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    instance-of v0, p4, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;

    if-eqz v0, :cond_0

    move-object v0, p4

    check-cast v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;

    iget v1, v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;->label:I

    const/high16 v2, -0x80000000

    and-int/2addr v1, v2

    if-eqz v1, :cond_0

    iget p4, v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;->label:I

    sub-int/2addr p4, v2

    iput p4, v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;->label:I

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;

    invoke-direct {v0, p0, p4}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;Lkotlin/coroutines/Continuation;)V

    :goto_0
    move-object p4, v0

    .local p4, "$continuation":Lkotlin/coroutines/Continuation;
    iget-object v0, p4, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;->result:Ljava/lang/Object;

    .local v0, "$result":Ljava/lang/Object;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 153
    iget v2, p4, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;->label:I

    const/4 v3, 0x1

    const/4 v4, 0x0

    packed-switch v2, :pswitch_data_0

    .end local v0    # "$result":Ljava/lang/Object;
    .end local p4    # "$continuation":Lkotlin/coroutines/Continuation;
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .restart local v0    # "$result":Ljava/lang/Object;
    .restart local p4    # "$continuation":Lkotlin/coroutines/Continuation;
    :pswitch_0
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto/16 :goto_3

    :pswitch_1
    iget-object p1, p4, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;->L$2:Ljava/lang/Object;

    check-cast p1, Lkotlin/jvm/functions/Function1;

    .local p1, "onResult":Lkotlin/jvm/functions/Function1;
    iget-object p2, p4, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;->L$1:Ljava/lang/Object;

    check-cast p2, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    .local p2, "appListener":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    iget-object p3, p4, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;->L$0:Ljava/lang/Object;

    check-cast p3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    .local p3, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    :try_start_0
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 172
    :catch_0
    move-exception v2

    goto :goto_2

    .line 153
    .end local p1    # "onResult":Lkotlin/jvm/functions/Function1;
    .end local p2    # "appListener":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .end local p3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    :pswitch_2
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v2, p0

    .line 158
    .local v2, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    .local p1, "host":Ljava/lang/String;
    .restart local p2    # "appListener":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .local p3, "onResult":Lkotlin/jvm/functions/Function1;
    nop

    .line 159
    :try_start_1
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v5

    check-cast v5, Lkotlin/coroutines/CoroutineContext;

    new-instance v6, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$2;

    invoke-direct {v6, v2, p1, v4}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$2;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    check-cast v6, Lkotlin/jvm/functions/Function2;

    iput-object v2, p4, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;->L$0:Ljava/lang/Object;

    iput-object p2, p4, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;->L$1:Ljava/lang/Object;

    iput-object p3, p4, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;->L$2:Ljava/lang/Object;

    iput v3, p4, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;->label:I

    invoke-static {v5, v6, p4}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v4
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .end local p1    # "host":Ljava/lang/String;
    if-ne v4, v1, :cond_1

    .line 153
    return-object v1

    .line 159
    :cond_1
    move-object p1, p3

    move-object p3, v2

    .line 171
    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    .local p1, "onResult":Lkotlin/jvm/functions/Function1;
    .local p3, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    :goto_1
    nop

    .end local p1    # "onResult":Lkotlin/jvm/functions/Function1;
    .end local p2    # "appListener":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .end local p3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    goto :goto_4

    .line 172
    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    .restart local p2    # "appListener":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .local p3, "onResult":Lkotlin/jvm/functions/Function1;
    :catch_1
    move-exception p1

    move-object v7, v2

    move-object v2, p1

    move-object p1, p3

    move-object p3, v7

    .line 173
    .local v2, "e":Ljava/lang/Exception;
    .restart local p1    # "onResult":Lkotlin/jvm/functions/Function1;
    .local p3, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    :goto_2
    iget-object v3, p3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->TAG:Ljava/lang/String;

    .end local p3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "flow=file src=phone stage=connect event=failed type="

    invoke-virtual {p3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    filled-new-array {p3}, [Ljava/lang/Object;

    move-result-object p3

    .end local v2    # "e":Ljava/lang/Exception;
    invoke-static {v3, p3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 174
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object p3

    check-cast p3, Lkotlin/coroutines/CoroutineContext;

    new-instance v2, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$3;

    invoke-direct {v2, p2, p1, v4}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$3;-><init>(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V

    check-cast v2, Lkotlin/jvm/functions/Function2;

    iput-object v4, p4, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;->L$0:Ljava/lang/Object;

    iput-object v4, p4, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;->L$1:Ljava/lang/Object;

    iput-object v4, p4, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;->L$2:Ljava/lang/Object;

    const/4 v3, 0x2

    iput v3, p4, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$connectSocket$1;->label:I

    invoke-static {p3, v2, p4}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p1

    .end local p1    # "onResult":Lkotlin/jvm/functions/Function1;
    .end local p2    # "appListener":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    if-ne p1, v1, :cond_2

    .line 153
    return-object v1

    .line 178
    :cond_2
    :goto_3
    const/4 v3, 0x0

    :goto_4
    invoke-static {v3}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object p1

    .line 158
    return-object p1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final notifyMain(Lkotlin/jvm/functions/Function0;)V
    .locals 2
    .param p1, "block"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 183
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    goto :goto_0

    .line 184
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->mainHandler:Landroid/os/Handler;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$$ExternalSyntheticLambda0;-><init>(Lkotlin/jvm/functions/Function0;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 185
    :goto_0
    return-void
.end method

.method private static final notifyMain$lambda$1(Lkotlin/jvm/functions/Function0;)V
    .locals 1
    .param p0, "$tmp0"    # Lkotlin/jvm/functions/Function0;

    const-string v0, "$tmp0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 184
    invoke-interface {p0}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    return-void
.end method

.method private final readResumeOffset(J)J
    .locals 9
    .param p1, "fileLength"    # J

    .line 136
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->socket:Ljava/net/Socket;

    const-wide/16 v1, 0x0

    if-nez v0, :cond_0

    return-wide v1

    .line 137
    .local v0, "activeSocket":Ljava/net/Socket;
    :cond_0
    invoke-virtual {v0}, Ljava/net/Socket;->getSoTimeout()I

    move-result v3

    .line 138
    .local v3, "originalTimeout":I
    nop

    .line 139
    const/16 v4, 0x7d0

    :try_start_0
    invoke-virtual {v0, v4}, Ljava/net/Socket;->setSoTimeout(I)V

    .line 140
    new-instance v4, Ljava/io/DataInputStream;

    invoke-virtual {v0}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V

    .line 141
    .local v4, "input":Ljava/io/DataInputStream;
    invoke-virtual {v4}, Ljava/io/DataInputStream;->readInt()I

    move-result v5

    .line 142
    .local v5, "magic":I
    const v6, 0x4f544131

    if-eq v5, v6, :cond_1

    goto :goto_0

    .line 143
    :cond_1
    sget-object v6, Lcom/rokid/security/sdk/base/common/ResumableFileTransferPolicy;->INSTANCE:Lcom/rokid/security/sdk/base/common/ResumableFileTransferPolicy;

    invoke-virtual {v4}, Ljava/io/DataInputStream;->readLong()J

    move-result-wide v7

    invoke-virtual {v6, v7, v8, p1, p2}, Lcom/rokid/security/sdk/base/common/ResumableFileTransferPolicy;->validOffset(JJ)J

    move-result-wide v1
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 149
    .end local v4    # "input":Ljava/io/DataInputStream;
    .end local v5    # "magic":I
    :goto_0
    :try_start_1
    sget-object v4, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v4, p0

    check-cast v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    .line 205
    .local v4, "$this$readResumeOffset_u24lambda_u240":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    const/4 v5, 0x0

    .line 149
    .local v5, "$i$a$-runCatching-FileSender$readResumeOffset$1":I
    invoke-virtual {v0, v3}, Ljava/net/Socket;->setSoTimeout(I)V

    .end local v4    # "$this$readResumeOffset_u24lambda_u240":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    .end local v5    # "$i$a$-runCatching-FileSender$readResumeOffset$1":I
    sget-object v4, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-static {v4}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_3

    :catchall_0
    move-exception v4

    goto :goto_2

    :catchall_1
    move-exception v1

    :try_start_2
    sget-object v2, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v2, p0

    .line 205
    .local v2, "$this$readResumeOffset_u24lambda_u240":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    const/4 v4, 0x0

    .line 149
    .local v4, "$i$a$-runCatching-FileSender$readResumeOffset$1":I
    invoke-virtual {v0, v3}, Ljava/net/Socket;->setSoTimeout(I)V

    .end local v2    # "$this$readResumeOffset_u24lambda_u240":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    .end local v4    # "$i$a$-runCatching-FileSender$readResumeOffset$1":I
    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-static {v2}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    goto :goto_1

    :catchall_2
    move-exception v2

    sget-object v4, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v2}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    :goto_1
    throw v1

    .line 144
    :catch_0
    move-exception v4

    .line 147
    .local v4, "_":Ljava/io/IOException;
    nop

    .line 149
    .end local v4    # "_":Ljava/io/IOException;
    :try_start_3
    sget-object v4, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v4, p0

    .line 205
    .local v4, "$this$readResumeOffset_u24lambda_u240":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    const/4 v5, 0x0

    .line 149
    .restart local v5    # "$i$a$-runCatching-FileSender$readResumeOffset$1":I
    invoke-virtual {v0, v3}, Ljava/net/Socket;->setSoTimeout(I)V

    .end local v4    # "$this$readResumeOffset_u24lambda_u240":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    .end local v5    # "$i$a$-runCatching-FileSender$readResumeOffset$1":I
    sget-object v4, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-static {v4}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    goto :goto_3

    :catchall_3
    move-exception v4

    :goto_2
    sget-object v5, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v4}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v4

    invoke-static {v4}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    .line 150
    :goto_3
    nop

    .line 138
    return-wide v1
.end method


# virtual methods
.method public final close()V
    .locals 2

    .line 200
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->disconnectSocket()V

    .line 201
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->TAG:Ljava/lang/String;

    const-string v1, " cancel"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 202
    return-void
.end method

.method public final disconnectSocket()V
    .locals 4

    .line 188
    nop

    .line 189
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->job:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {v0, v2, v1, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 190
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->dataOutputStream:Ljava/io/DataOutputStream;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/io/DataOutputStream;->close()V

    .line 191
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->outputStream:Ljava/io/OutputStream;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V

    .line 192
    :cond_2
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->socket:Ljava/net/Socket;

    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/net/Socket;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 193
    :catch_0
    move-exception v0

    .line 194
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "flow=file src=phone stage=disconnect event=failed type="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 196
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_3
    :goto_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->TAG:Ljava/lang/String;

    const-string v1, " disconnectSocket"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 197
    return-void
.end method

.method public final isSendingFile()Z
    .locals 3

    .line 41
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->job:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-interface {v0}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    move v1, v2

    :cond_0
    return v1
.end method

.method public final sendFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;)V
    .locals 10
    .param p1, "host"    # Ljava/lang/String;
    .param p2, "dir"    # Ljava/lang/String;
    .param p3, "file"    # Ljava/io/File;
    .param p4, "appListener"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .param p5, "onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/io/File;",
            "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "host"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "file"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onResult"

    invoke-static {p5, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 50
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->job:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-interface {v0}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    goto :goto_0

    :cond_0
    move v2, v1

    :goto_0
    if-eqz v2, :cond_1

    .line 51
    const-string v0, "There is a file being sent. Please try again later."

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 52
    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$1;

    invoke-direct {v0, p4, p5}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$1;-><init>(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;)V

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-direct {p0, v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->notifyMain(Lkotlin/jvm/functions/Function0;)V

    .line 56
    return-void

    .line 58
    :cond_1
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->close()V

    .line 59
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;

    const/4 v9, 0x0

    move-object v2, v0

    move-object v3, p0

    move-object v4, p1

    move-object v5, p4

    move-object v6, p5

    move-object v7, p3

    move-object v8, p2

    invoke-direct/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Ljava/io/File;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->job:Lkotlinx/coroutines/Job;

    .line 133
    return-void
.end method
