.class final Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "OnlineRecManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->recognizeFace(Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;)V
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
    value = "SMAP\nOnlineRecManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 OnlineRecManager.kt\ncom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult\n*L\n1#1,226:1\n42#2,4:227\n*S KotlinDebug\n*F\n+ 1 OnlineRecManager.kt\ncom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1\n*L\n144#1:227,4\n*E\n"
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
    c = "com.rokid.security.phone.sdk.server.recog.online.OnlineRecManager$recognizeFace$1"
    f = "OnlineRecManager.kt"
    i = {
        0x0
    }
    l = {
        0x89
    }
    m = "invokeSuspend"
    n = {
        "time1"
    }
    s = {
        "J$0"
    }
.end annotation


# instance fields
.field final synthetic $extra:Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;

.field J$0:J

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;",
            "Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->$extra:Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;

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

    new-instance v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->$extra:Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;

    invoke-direct {v0, v1, v2, p2}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;-><init>(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 16

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 107
    move-object/from16 v1, p0

    iget v2, v1, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->label:I

    const-string v3, " trackId="

    const-string v4, " frameId="

    const/4 v5, 0x1

    const/4 v6, -0x1

    const/4 v7, 0x0

    const/4 v8, 0x0

    packed-switch v2, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v2, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    move-object/from16 v0, p0

    .local v0, "this":Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;
    move-object/from16 v2, p1

    .local v2, "$result":Ljava/lang/Object;
    iget-wide v9, v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->J$0:J

    .local v9, "time1":J
    invoke-static {v2}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v6, v2

    goto/16 :goto_2

    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;
    .end local v2    # "$result":Ljava/lang/Object;
    .end local v9    # "time1":J
    :pswitch_1
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v2, p0

    .local v2, "this":Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;
    move-object/from16 v9, p1

    .line 108
    .local v9, "$result":Ljava/lang/Object;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v10

    .line 109
    .local v10, "time":J
    iget-object v12, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-static {v12}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Ljava/lang/String;

    move-result-object v12

    const-string v13, "recognizeFace"

    filled-new-array {v13}, [Ljava/lang/Object;

    move-result-object v13

    invoke-static {v12, v13}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 110
    iget-object v12, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-static {v12}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$getMRecProvider$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;

    move-result-object v12

    if-nez v12, :cond_0

    .line 111
    sget-object v12, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v12}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getEnvType()Ljava/lang/String;

    move-result-object v12

    const-string v13, "custom"

    invoke-static {v12, v13}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v12

    if-nez v12, :cond_0

    .line 112
    .end local v10    # "time":J
    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    const/16 v3, -0x63

    const-string/jumbo v4, "\u5f53\u524d\u73af\u5883\u4e0d\u652f\u6301\u8be5\u670d\u52a1"

    invoke-static {v0, v8, v7, v4, v3}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$sendRecogFaceResponseMsg(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;ZLcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;Ljava/lang/String;I)V

    .line 113
    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Ljava/lang/String;

    move-result-object v0

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 114
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    .line 117
    .restart local v10    # "time":J
    :cond_0
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v13, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->$extra:Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;

    invoke-virtual {v13}, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->getTrackId()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, ".jpeg"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    .line 118
    .local v12, "tag":Ljava/lang/String;
    iget-object v13, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-static {v13}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$getDataMap$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Lcom/rokid/security/phone/sdk/server/common/FixedSizeMap;

    move-result-object v13

    invoke-virtual {v13, v12}, Lcom/rokid/security/phone/sdk/server/common/FixedSizeMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, [B

    .line 119
    .local v13, "data":[B
    if-nez v13, :cond_1

    .line 120
    .end local v10    # "time":J
    .end local v12    # "tag":Ljava/lang/String;
    .end local v13    # "data":[B
    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    const-string/jumbo v3, "\u4eba\u8138\u4f20\u8f93\u5931\u8d25\uff0c\u8bf7\u91cd\u8bd5"

    invoke-static {v0, v8, v7, v3, v6}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$sendRecogFaceResponseMsg(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;ZLcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;Ljava/lang/String;I)V

    .line 121
    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Ljava/lang/String;

    move-result-object v0

    const-string v3, "data is not exist"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 122
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    .line 125
    .restart local v10    # "time":J
    .restart local v12    # "tag":Ljava/lang/String;
    .restart local v13    # "data":[B
    :cond_1
    iget-object v14, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-static {v14}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$getMRecProvider$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;

    move-result-object v14

    if-nez v14, :cond_f

    .line 127
    sget-object v14, Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;

    invoke-virtual {v14, v13}, Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;->dataToBase64([B)Ljava/lang/String;

    move-result-object v13

    .line 128
    .local v13, "base64Str":Ljava/lang/String;
    iget-object v14, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-static {v14}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$getDataMap$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Lcom/rokid/security/phone/sdk/server/common/FixedSizeMap;

    move-result-object v14

    invoke-virtual {v14, v12}, Lcom/rokid/security/phone/sdk/server/common/FixedSizeMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 129
    .end local v12    # "tag":Ljava/lang/String;
    move-object v12, v13

    check-cast v12, Ljava/lang/CharSequence;

    if-eqz v12, :cond_3

    invoke-interface {v12}, Ljava/lang/CharSequence;->length()I

    move-result v12

    if-nez v12, :cond_2

    goto :goto_0

    :cond_2
    move v12, v8

    goto :goto_1

    :cond_3
    :goto_0
    move v12, v5

    :goto_1
    if-eqz v12, :cond_4

    .line 130
    .end local v10    # "time":J
    .end local v13    # "base64Str":Ljava/lang/String;
    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    const-string/jumbo v3, "\u4eba\u8138\u6570\u636e\u683c\u5f0f\u9519\u8bef"

    invoke-static {v0, v8, v7, v3, v6}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$sendRecogFaceResponseMsg(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;ZLcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;Ljava/lang/String;I)V

    .line 131
    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Ljava/lang/String;

    move-result-object v0

    const-string v3, "data to base64Str Fail"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 132
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    .line 134
    .restart local v10    # "time":J
    .restart local v13    # "base64Str":Ljava/lang/String;
    :cond_4
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v14

    .line 135
    .local v14, "time1":J
    iget-object v12, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-static {v12}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Ljava/lang/String;

    move-result-object v12

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "face encode costMs="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    move-object/from16 p1, v9

    .end local v9    # "$result":Ljava/lang/Object;
    .local p1, "$result":Ljava/lang/Object;
    sub-long v8, v14, v10

    invoke-virtual {v6, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v8, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->$extra:Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;

    invoke-virtual {v8}, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->getFrameId()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v8, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->$extra:Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;

    invoke-virtual {v8}, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->getTrackId()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    .end local v10    # "time":J
    invoke-static {v12, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 137
    new-instance v6, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1$retPair$1;

    iget-object v8, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-direct {v6, v8, v13}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1$retPair$1;-><init>(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;Ljava/lang/String;)V

    check-cast v6, Lkotlin/jvm/functions/Function0;

    move-object v8, v2

    check-cast v8, Lkotlin/coroutines/Continuation;

    iput-wide v14, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->J$0:J

    iput v5, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->label:I

    invoke-static {v6, v8}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt;->api2Call4(Lkotlin/jvm/functions/Function0;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v6

    .end local v13    # "base64Str":Ljava/lang/String;
    if-ne v6, v0, :cond_5

    .line 107
    return-object v0

    .line 137
    :cond_5
    move-object v0, v2

    move-object v2, v6

    move-wide v9, v14

    move-object/from16 v6, p1

    .line 107
    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;
    .end local v14    # "time1":J
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;
    .local v6, "$result":Ljava/lang/Object;
    .local v9, "time1":J
    :goto_2
    check-cast v2, Lkotlin/Pair;

    .line 139
    .local v2, "retPair":Lkotlin/Pair;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v11

    .line 140
    .local v11, "time2":J
    iget-object v8, v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-static {v8}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Ljava/lang/String;

    move-result-object v8

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "face request costMs="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    sub-long v14, v11, v9

    invoke-virtual {v13, v14, v15}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v13, v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->$extra:Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;

    invoke-virtual {v13}, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->getFrameId()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v4, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->$extra:Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->getTrackId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    .end local v9    # "time1":J
    .end local v11    # "time2":J
    invoke-static {v8, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 142
    invoke-virtual {v2}, Lkotlin/Pair;->getFirst()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->unbox-impl()Ljava/lang/Object;

    move-result-object v3

    .line 143
    .local v3, "ret":Ljava/lang/Object;
    invoke-static {v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isSuccess-impl(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_a

    .line 144
    const/4 v4, 0x0

    .line 227
    .local v4, "$i$f$getOrNull-impl":I
    nop

    .line 228
    invoke-static {v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_6

    const/4 v3, 0x0

    goto :goto_3

    .line 229
    :cond_6
    nop

    .line 230
    .end local v3    # "ret":Ljava/lang/Object;
    :goto_3
    nop

    .line 144
    .end local v4    # "$i$f$getOrNull-impl":I
    check-cast v3, Ljava/util/List;

    .line 145
    .local v3, "data":Ljava/util/List;
    move-object v4, v3

    check-cast v4, Ljava/util/Collection;

    if-eqz v4, :cond_8

    invoke-interface {v4}, Ljava/util/Collection;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_7

    goto :goto_4

    :cond_7
    const/4 v5, 0x0

    :cond_8
    :goto_4
    if-nez v5, :cond_9

    .line 146
    .end local v2    # "retPair":Lkotlin/Pair;
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Ljava/lang/String;

    move-result-object v2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "recognizeFace success count="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v2, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 147
    iget-object v8, v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    const/4 v2, 0x0

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    move-object v10, v2

    check-cast v10, Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;

    const/16 v13, 0xc

    const/4 v14, 0x0

    const/4 v9, 0x1

    const/4 v11, 0x0

    const/4 v12, 0x0

    invoke-static/range {v8 .. v14}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->sendRecogFaceResponseMsg$default(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;ZLcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;Ljava/lang/String;IILjava/lang/Object;)V

    goto/16 :goto_7

    .line 149
    .restart local v2    # "retPair":Lkotlin/Pair;
    :cond_9
    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-static {v4}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "recognizeFace Fail: data = "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v8, ", message = "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v2}, Lkotlin/Pair;->getSecond()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    .end local v3    # "data":Ljava/util/List;
    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 150
    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    .line 151
    nop

    .line 152
    nop

    .line 153
    invoke-virtual {v2}, Lkotlin/Pair;->getSecond()Ljava/lang/Object;

    move-result-object v4

    invoke-static {v4}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 154
    .end local v2    # "retPair":Lkotlin/Pair;
    nop

    .line 150
    const/4 v4, -0x1

    const/4 v5, 0x0

    const/4 v7, 0x0

    invoke-static {v3, v7, v5, v2, v4}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$sendRecogFaceResponseMsg(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;ZLcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;Ljava/lang/String;I)V

    goto :goto_7

    .line 143
    .restart local v2    # "retPair":Lkotlin/Pair;
    .local v3, "ret":Ljava/lang/Object;
    :cond_a
    const/4 v4, -0x1

    .line 158
    .end local v2    # "retPair":Lkotlin/Pair;
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Ljava/lang/String;

    move-result-object v2

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "recognizeFace Fail: error message = "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->exceptionOrNull-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    move-result-object v8

    if-eqz v8, :cond_b

    invoke-virtual {v8}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;->getMessage()Ljava/lang/String;

    move-result-object v8

    goto :goto_5

    :cond_b
    const/4 v8, 0x0

    :goto_5
    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v2, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 159
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    .line 160
    nop

    .line 161
    nop

    .line 162
    invoke-static {v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->exceptionOrNull-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    move-result-object v5

    if-eqz v5, :cond_c

    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;->getMessage()Ljava/lang/String;

    move-result-object v5

    if-nez v5, :cond_d

    :cond_c
    const-string/jumbo v5, "\u8bf7\u6c42\u8d85\u65f6\uff0c\u624b\u673a\u7f51\u7edc\u5f02\u5e38"

    .line 163
    :cond_d
    invoke-static {v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->exceptionOrNull-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    move-result-object v3

    .end local v3    # "ret":Ljava/lang/Object;
    if-eqz v3, :cond_e

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;->getCode()I

    move-result v3

    goto :goto_6

    :cond_e
    move v3, v4

    .line 159
    :goto_6
    const/4 v4, 0x0

    const/4 v7, 0x0

    invoke-static {v2, v7, v4, v5, v3}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$sendRecogFaceResponseMsg(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;ZLcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;Ljava/lang/String;I)V

    .line 196
    :goto_7
    move-object v2, v0

    move-object v9, v6

    goto :goto_9

    .line 125
    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;
    .end local v6    # "$result":Ljava/lang/Object;
    .local v2, "this":Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;
    .local v9, "$result":Ljava/lang/Object;
    .restart local v10    # "time":J
    .restart local v12    # "tag":Ljava/lang/String;
    .local v13, "data":[B
    :cond_f
    move-object/from16 p1, v9

    .line 167
    .end local v9    # "$result":Ljava/lang/Object;
    .end local v10    # "time":J
    .end local v12    # "tag":Ljava/lang/String;
    .restart local p1    # "$result":Ljava/lang/Object;
    nop

    .line 168
    :try_start_0
    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Ljava/lang/String;

    move-result-object v0

    const-string v3, "mRecProvider != null"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 169
    new-instance v0, Lcom/rokid/security/phone/sdk/api/recog/online/bean/RecogFaceParam;

    iget-object v3, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->$extra:Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->getTrackId()Ljava/lang/String;

    move-result-object v3

    iget-object v4, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->$extra:Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->getFrameId()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v0, v13, v3, v4}, Lcom/rokid/security/phone/sdk/api/recog/online/bean/RecogFaceParam;-><init>([BLjava/lang/String;Ljava/lang/String;)V

    .line 170
    .local v0, "param":Lcom/rokid/security/phone/sdk/api/recog/online/bean/RecogFaceParam;
    new-instance v3, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1$callback$1;

    iget-object v4, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-direct {v3, v4, v13}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1$callback$1;-><init>(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;[B)V

    .line 191
    .end local v13    # "data":[B
    .local v3, "callback":Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1$callback$1;
    iget-object v4, v2, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-static {v4}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$getMRecProvider$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;

    move-result-object v4

    if-eqz v4, :cond_10

    move-object v5, v3

    check-cast v5, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    invoke-interface {v4, v0, v5}, Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;->recognizeFace(Lcom/rokid/security/phone/sdk/api/recog/online/bean/RecogFaceParam;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_8

    .end local v0    # "param":Lcom/rokid/security/phone/sdk/api/recog/online/bean/RecogFaceParam;
    .end local v3    # "callback":Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1$callback$1;
    :cond_10
    goto :goto_8

    .line 192
    :catch_0
    move-exception v0

    .line 193
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 196
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_8
    move-object/from16 v9, p1

    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v9    # "$result":Ljava/lang/Object;
    :goto_9
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
