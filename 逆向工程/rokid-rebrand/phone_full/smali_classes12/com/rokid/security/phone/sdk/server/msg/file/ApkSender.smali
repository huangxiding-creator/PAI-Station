.class public final Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
.super Ljava/lang/Object;
.source "ApkSender.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000X\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0007\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0012\n\u0000\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0012\u001a\u00020\u0013J\u0019\u0010\u0014\u001a\u00020\u00152\u0006\u0010\u0016\u001a\u00020\u0007H\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\u0017J\u0006\u0010\u0018\u001a\u00020\u0013J\u0010\u0010\u0019\u001a\u00020\u00072\u0006\u0010\u001a\u001a\u00020\u0007H\u0002J+\u0010\u001b\u001a\u00020\u00132\u0006\u0010\u0010\u001a\u00020\u00112\u0006\u0010\u001c\u001a\u00020\u001d2\u0008\u0010\u001e\u001a\u0004\u0018\u00010\u001fH\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010 J \u0010\u001b\u001a\u00020\u00132\u0006\u0010\u0016\u001a\u00020\u00072\u0006\u0010\u001c\u001a\u00020\u001d2\u0008\u0010\u001e\u001a\u0004\u0018\u00010\u001fJ \u0010!\u001a\u00020\u00132\u0006\u0010\"\u001a\u00020\n2\u0006\u0010#\u001a\u00020\u00042\u0006\u0010$\u001a\u00020%H\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0007X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0010\u0010\t\u001a\u0004\u0018\u00010\nX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000b\u001a\u0004\u0018\u00010\u000cX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\r\u001a\u00020\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000e\u001a\u0004\u0018\u00010\u000fX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0010\u001a\u0004\u0018\u00010\u0011X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006&"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;",
        "",
        "()V",
        "BLOCK_SIZE",
        "",
        "PROGRESS_INTERVAL_MS",
        "TAG",
        "",
        "connectTimeout",
        "dataOutputStream",
        "Ljava/io/DataOutputStream;",
        "job",
        "Lkotlinx/coroutines/Job;",
        "mPort",
        "outputStream",
        "Ljava/io/OutputStream;",
        "socket",
        "Ljava/net/Socket;",
        "close",
        "",
        "connectSocket",
        "",
        "host",
        "(Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "disconnectSocket",
        "getFileType",
        "fileName",
        "sendFile",
        "file",
        "Ljava/io/File;",
        "listener",
        "Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;",
        "(Ljava/net/Socket;Ljava/io/File;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "sendPacket",
        "out",
        "type",
        "data",
        "",
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
.field private final BLOCK_SIZE:I

.field private final PROGRESS_INTERVAL_MS:I

.field private final TAG:Ljava/lang/String;

.field private final connectTimeout:I

.field private dataOutputStream:Ljava/io/DataOutputStream;

.field private job:Lkotlinx/coroutines/Job;

.field private final mPort:I

.field private outputStream:Ljava/io/OutputStream;

.field private socket:Ljava/net/Socket;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    const-string v0, "ApkSender"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->TAG:Ljava/lang/String;

    .line 27
    sget-object v0, Lcom/rokid/security/sdk/base/common/apk/Apk3rdUtil;->INSTANCE:Lcom/rokid/security/sdk/base/common/apk/Apk3rdUtil;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/apk/Apk3rdUtil;->getPort()I

    move-result v0

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->mPort:I

    .line 32
    const/16 v0, 0x1388

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->connectTimeout:I

    .line 34
    const/16 v0, 0x2000

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->BLOCK_SIZE:I

    .line 35
    const/16 v0, 0x64

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->PROGRESS_INTERVAL_MS:I

    .line 25
    return-void
.end method

.method public static final synthetic access$connectSocket(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    .param p1, "host"    # Ljava/lang/String;
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 25
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->connectSocket(Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getBLOCK_SIZE$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)I
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    .line 25
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->BLOCK_SIZE:I

    return v0
.end method

.method public static final synthetic access$getConnectTimeout$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)I
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    .line 25
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->connectTimeout:I

    return v0
.end method

.method public static final synthetic access$getFileType(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    .param p1, "fileName"    # Ljava/lang/String;

    .line 25
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->getFileType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getMPort$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)I
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    .line 25
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->mPort:I

    return v0
.end method

.method public static final synthetic access$getOutputStream$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)Ljava/io/OutputStream;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    .line 25
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->outputStream:Ljava/io/OutputStream;

    return-object v0
.end method

.method public static final synthetic access$getPROGRESS_INTERVAL_MS$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)I
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    .line 25
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->PROGRESS_INTERVAL_MS:I

    return v0
.end method

.method public static final synthetic access$getSocket$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)Ljava/net/Socket;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    .line 25
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->socket:Ljava/net/Socket;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    .line 25
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$sendFile(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/net/Socket;Ljava/io/File;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    .param p1, "socket"    # Ljava/net/Socket;
    .param p2, "file"    # Ljava/io/File;
    .param p3, "listener"    # Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;
    .param p4, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 25
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->sendFile(Ljava/net/Socket;Ljava/io/File;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$sendPacket(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/io/DataOutputStream;I[B)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    .param p1, "out"    # Ljava/io/DataOutputStream;
    .param p2, "type"    # I
    .param p3, "data"    # [B

    .line 25
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->sendPacket(Ljava/io/DataOutputStream;I[B)V

    return-void
.end method

.method public static final synthetic access$setDataOutputStream$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/io/DataOutputStream;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    .param p1, "<set-?>"    # Ljava/io/DataOutputStream;

    .line 25
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->dataOutputStream:Ljava/io/DataOutputStream;

    return-void
.end method

.method public static final synthetic access$setOutputStream$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/io/OutputStream;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    .param p1, "<set-?>"    # Ljava/io/OutputStream;

    .line 25
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->outputStream:Ljava/io/OutputStream;

    return-void
.end method

.method public static final synthetic access$setSocket$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/net/Socket;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    .param p1, "<set-?>"    # Ljava/net/Socket;

    .line 25
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->socket:Ljava/net/Socket;

    return-void
.end method

.method private final connectSocket(Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Ljava/lang/Boolean;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    instance-of v0, p2, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$1;

    if-eqz v0, :cond_0

    move-object v0, p2

    check-cast v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$1;

    iget v1, v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$1;->label:I

    const/high16 v2, -0x80000000

    and-int/2addr v1, v2

    if-eqz v1, :cond_0

    iget p2, v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$1;->label:I

    sub-int/2addr p2, v2

    iput p2, v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$1;->label:I

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$1;

    invoke-direct {v0, p0, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Lkotlin/coroutines/Continuation;)V

    :goto_0
    move-object p2, v0

    .local p2, "$continuation":Lkotlin/coroutines/Continuation;
    iget-object v0, p2, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$1;->result:Ljava/lang/Object;

    .local v0, "$result":Ljava/lang/Object;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 177
    iget v2, p2, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$1;->label:I

    const/4 v3, 0x1

    const/4 v4, 0x0

    packed-switch v2, :pswitch_data_0

    .end local v0    # "$result":Ljava/lang/Object;
    .end local p2    # "$continuation":Lkotlin/coroutines/Continuation;
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .restart local v0    # "$result":Ljava/lang/Object;
    .restart local p2    # "$continuation":Lkotlin/coroutines/Continuation;
    :pswitch_0
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto :goto_3

    :pswitch_1
    iget-object p1, p2, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$1;->L$0:Ljava/lang/Object;

    check-cast p1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    .local p1, "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    :try_start_0
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 189
    :catch_0
    move-exception v2

    goto :goto_2

    .line 177
    .end local p1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    :pswitch_2
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v2, p0

    .line 178
    .local v2, "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    .local p1, "host":Ljava/lang/String;
    nop

    .line 179
    :try_start_1
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v5

    check-cast v5, Lkotlin/coroutines/CoroutineContext;

    new-instance v6, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;

    invoke-direct {v6, v2, p1, v4}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$2;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    check-cast v6, Lkotlin/jvm/functions/Function2;

    iput-object v2, p2, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$1;->L$0:Ljava/lang/Object;

    iput v3, p2, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$1;->label:I

    invoke-static {v5, v6, p2}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v5
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .end local p1    # "host":Ljava/lang/String;
    if-ne v5, v1, :cond_1

    .line 177
    return-object v1

    .line 179
    :cond_1
    move-object p1, v2

    .line 188
    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    .local p1, "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    :goto_1
    :try_start_2
    invoke-static {v3}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v1
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    return-object v1

    .line 189
    .end local p1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    :catch_1
    move-exception p1

    move-object v7, v2

    move-object v2, p1

    move-object p1, v7

    .line 190
    .local v2, "e":Ljava/lang/Exception;
    .restart local p1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    :goto_2
    iget-object v3, p1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->TAG:Ljava/lang/String;

    .end local p1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "connectSocket Exception "

    invoke-virtual {p1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    .end local v2    # "e":Ljava/lang/Exception;
    invoke-static {v3, p1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 191
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object p1

    check-cast p1, Lkotlin/coroutines/CoroutineContext;

    new-instance v2, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$3;

    invoke-direct {v2, v4}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$3;-><init>(Lkotlin/coroutines/Continuation;)V

    check-cast v2, Lkotlin/jvm/functions/Function2;

    iput-object v4, p2, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$1;->L$0:Ljava/lang/Object;

    const/4 v3, 0x2

    iput v3, p2, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$connectSocket$1;->label:I

    invoke-static {p1, v2, p2}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p1

    if-ne p1, v1, :cond_2

    .line 177
    return-object v1

    .line 194
    :cond_2
    :goto_3
    const/4 p1, 0x0

    invoke-static {p1}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object p1

    return-object p1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final getFileType(Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p1, "fileName"    # Ljava/lang/String;

    .line 170
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const/4 v4, 0x6

    const/4 v5, 0x0

    const/16 v1, 0x2e

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static/range {v0 .. v5}, Lkotlin/text/StringsKt;->lastIndexOf$default(Ljava/lang/CharSequence;CIZILjava/lang/Object;)I

    move-result v0

    .line 171
    .local v0, "dotIndex":I
    if-lez v0, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    if-ge v0, v1, :cond_0

    .line 172
    add-int/lit8 v1, v0, 0x1

    invoke-virtual {p1, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v2, "this as java.lang.String).substring(startIndex)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v2, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v2, "this as java.lang.String).toLowerCase(Locale.ROOT)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    goto :goto_0

    .line 174
    :cond_0
    const-string/jumbo v1, "unknown"

    .line 171
    :goto_0
    return-object v1
.end method

.method private final sendFile(Ljava/net/Socket;Ljava/io/File;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 8
    .param p1, "socket"    # Ljava/net/Socket;
    .param p2, "file"    # Ljava/io/File;
    .param p3, "listener"    # Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;
    .param p4, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/net/Socket;",
            "Ljava/io/File;",
            "Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 81
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v7, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;

    const/4 v6, 0x0

    move-object v1, v7

    move-object v2, p0

    move-object v3, p2

    move-object v4, p1

    move-object v5, p3

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/io/File;Ljava/net/Socket;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Lkotlin/coroutines/Continuation;)V

    check-cast v7, Lkotlin/jvm/functions/Function2;

    invoke-static {v0, v7, p4}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    .line 154
    return-object v0
.end method

.method private final sendPacket(Ljava/io/DataOutputStream;I[B)V
    .locals 2
    .param p1, "out"    # Ljava/io/DataOutputStream;
    .param p2, "type"    # I
    .param p3, "data"    # [B

    .line 159
    invoke-virtual {p1, p2}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 160
    array-length v0, p3

    invoke-virtual {p1, v0}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 161
    array-length v0, p3

    const/4 v1, 0x1

    if-nez v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    xor-int/2addr v0, v1

    if-eqz v0, :cond_1

    .line 162
    invoke-virtual {p1, p3}, Ljava/io/DataOutputStream;->write([B)V

    .line 164
    :cond_1
    invoke-virtual {p1}, Ljava/io/DataOutputStream;->flush()V

    .line 165
    return-void
.end method


# virtual methods
.method public final close()V
    .locals 2

    .line 211
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->disconnectSocket()V

    .line 212
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->TAG:Ljava/lang/String;

    const-string v1, " cancel"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 213
    return-void
.end method

.method public final disconnectSocket()V
    .locals 4

    .line 199
    nop

    .line 200
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->job:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {v0, v2, v1, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 201
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->dataOutputStream:Ljava/io/DataOutputStream;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/io/DataOutputStream;->close()V

    .line 202
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->outputStream:Ljava/io/OutputStream;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V

    .line 203
    :cond_2
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->socket:Ljava/net/Socket;

    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/net/Socket;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 204
    :catch_0
    move-exception v0

    .line 205
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "disconnectSocket Exception "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 207
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_3
    :goto_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->TAG:Ljava/lang/String;

    const-string v1, " disconnectSocket"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 208
    return-void
.end method

.method public final sendFile(Ljava/lang/String;Ljava/io/File;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;)V
    .locals 8
    .param p1, "host"    # Ljava/lang/String;
    .param p2, "file"    # Ljava/io/File;
    .param p3, "listener"    # Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    const-string v0, "host"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "file"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->job:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    invoke-interface {v0}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v0

    if-ne v0, v2, :cond_0

    move v1, v2

    :cond_0
    if-eqz v1, :cond_2

    .line 43
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->TAG:Ljava/lang/String;

    const-string v1, "A file is being sent"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 44
    if-eqz p3, :cond_1

    invoke-interface {p3, v1}, Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;->onError(Ljava/lang/String;)V

    .line 45
    :cond_1
    return-void

    .line 47
    :cond_2
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->close()V

    .line 48
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {v1, v2, v1}, Lkotlinx/coroutines/SupervisorKt;->SupervisorJob$default(Lkotlinx/coroutines/Job;ILjava/lang/Object;)Lkotlinx/coroutines/CompletableJob;

    move-result-object v1

    check-cast v1, Lkotlin/coroutines/CoroutineContext;

    invoke-virtual {v0, v1}, Lkotlinx/coroutines/CoroutineDispatcher;->plus(Lkotlin/coroutines/CoroutineContext;)Lkotlin/coroutines/CoroutineContext;

    move-result-object v0

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;

    const/4 v7, 0x0

    move-object v2, v0

    move-object v3, p0

    move-object v4, p1

    move-object v5, p3

    move-object v6, p2

    invoke-direct/range {v2 .. v7}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Ljava/io/File;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->job:Lkotlinx/coroutines/Job;

    .line 71
    return-void
.end method
