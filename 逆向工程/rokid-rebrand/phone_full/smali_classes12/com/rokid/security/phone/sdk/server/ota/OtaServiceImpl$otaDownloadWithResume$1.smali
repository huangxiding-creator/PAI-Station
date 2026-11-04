.class final Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "OtaServiceImpl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->otaDownloadWithResume(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;J)V
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
    c = "com.rokid.security.phone.sdk.server.ota.OtaServiceImpl$otaDownloadWithResume$1"
    f = "OtaServiceImpl.kt"
    i = {}
    l = {
        0x11e,
        0x123
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $downloadedSize:J

.field final synthetic $listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

.field final synthetic $path:Ljava/lang/String;

.field final synthetic $url:Ljava/lang/String;

.field label:I


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;JLkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/api/base/DownloadListener;",
            "J",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->$url:Ljava/lang/String;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->$path:Ljava/lang/String;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    iput-wide p4, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->$downloadedSize:J

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

    new-instance v7, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->$url:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->$path:Ljava/lang/String;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    iget-wide v4, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->$downloadedSize:J

    move-object v0, v7

    move-object v6, p2

    invoke-direct/range {v0 .. v6}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;JLkotlin/coroutines/Continuation;)V

    check-cast v7, Lkotlin/coroutines/Continuation;

    return-object v7
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 13

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 284
    iget v1, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->label:I

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v0, p0

    .local v0, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;
    .local p1, "$result":Ljava/lang/Object;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto :goto_2

    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    move-object v1, p0

    .local v1, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    :try_start_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/util/concurrent/CancellationException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 289
    :catch_0
    move-exception v2

    goto :goto_1

    .line 287
    :catch_1
    move-exception v0

    goto :goto_4

    .line 284
    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_2
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .line 285
    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    nop

    .line 286
    :try_start_1
    sget-object v2, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->$url:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->$path:Ljava/lang/String;

    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    iget-wide v6, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->$downloadedSize:J

    move-object v8, v1

    check-cast v8, Lkotlin/coroutines/Continuation;

    const/4 v9, 0x1

    iput v9, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->label:I

    invoke-static/range {v2 .. v8}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->access$downloadWithRetrofit(Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2
    :try_end_1
    .catch Ljava/util/concurrent/CancellationException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    if-ne v2, v0, :cond_0

    .line 284
    return-object v0

    .line 286
    :cond_0
    :goto_0
    goto :goto_3

    .line 290
    .local v2, "e":Ljava/lang/Exception;
    :goto_1
    sget-object v3, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v3

    const-string/jumbo v4, "\u65ad\u70b9\u7eed\u4f20\u4e0b\u8f7d\u5f02\u5e38"

    filled-new-array {v4, v2}, [Ljava/lang/Object;

    move-result-object v4

    .end local v2    # "e":Ljava/lang/Exception;
    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 291
    sget-object v5, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    move-object v10, v1

    check-cast v10, Lkotlin/coroutines/Continuation;

    const/4 v2, 0x2

    iput v2, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;->label:I

    const/4 v7, -0x1

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/16 v11, 0xc

    const/4 v12, 0x0

    invoke-static/range {v5 .. v12}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->dispatchDownloadResult$default(Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    if-ne v2, v0, :cond_1

    .line 284
    return-object v0

    .line 291
    :cond_1
    move-object v0, v1

    .line 293
    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;
    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;
    :goto_2
    move-object v1, v0

    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;
    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;
    :goto_3
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    .line 288
    .local v0, "e":Ljava/util/concurrent/CancellationException;
    :goto_4
    throw v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
