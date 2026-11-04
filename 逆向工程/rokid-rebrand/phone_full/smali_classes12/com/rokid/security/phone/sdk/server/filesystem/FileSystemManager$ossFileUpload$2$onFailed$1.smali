.class final Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "FileSystemManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V
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
    c = "com.rokid.security.phone.sdk.server.filesystem.FileSystemManager$ossFileUpload$2$onFailed$1"
    f = "FileSystemManager.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $code:Ljava/lang/Integer;

.field final synthetic $errormsg:Ljava/lang/String;

.field final synthetic $filePath:Ljava/lang/String;

.field final synthetic $preCalculatedMd5:Ljava/lang/String;

.field label:I


# direct methods
.method constructor <init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->$code:Ljava/lang/Integer;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->$errormsg:Ljava/lang/String;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->$filePath:Ljava/lang/String;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->$preCalculatedMd5:Ljava/lang/String;

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

    new-instance v6, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->$code:Ljava/lang/Integer;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->$errormsg:Ljava/lang/String;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->$filePath:Ljava/lang/String;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->$preCalculatedMd5:Ljava/lang/String;

    move-object v0, v6

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;-><init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    check-cast v6, Lkotlin/coroutines/Continuation;

    return-object v6
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 5

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 338
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v0, p0

    .line 339
    .local v0, "this":Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;
    .local p1, "$result":Ljava/lang/Object;
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->access$getTAG$p()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ossFileUpload failed code="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->$code:Ljava/lang/Integer;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " errorPresent="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->$errormsg:Ljava/lang/String;

    check-cast v3, Ljava/lang/CharSequence;

    const/4 v4, 0x1

    if-eqz v3, :cond_1

    invoke-static {v3}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_0

    goto :goto_0

    :cond_0
    const/4 v3, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    move v3, v4

    :goto_1
    xor-int/2addr v3, v4

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 341
    sget-object v1, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->$filePath:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->decrementFileReference(Ljava/lang/String;)I

    .line 342
    sget-object v1, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->$errormsg:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->$preCalculatedMd5:Ljava/lang/String;

    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;->$filePath:Ljava/lang/String;

    invoke-static {v1, v2, v3, v4}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->access$onErrorListener(Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 343
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
