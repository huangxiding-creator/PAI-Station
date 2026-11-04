.class final Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "OfflineRecgManger.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->getPersonnelLib(Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;)V
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
    value = "SMAP\nOfflineRecgManger.kt\nKotlin\n*S Kotlin\n*F\n+ 1 OfflineRecgManger.kt\ncom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult\n*L\n1#1,361:1\n42#2,4:362\n*S KotlinDebug\n*F\n+ 1 OfflineRecgManger.kt\ncom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1\n*L\n156#1:362,4\n*E\n"
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
    c = "com.rokid.security.phone.sdk.server.recog.offline.OfflineRecgManger$getPersonnelLib$1"
    f = "OfflineRecgManger.kt"
    i = {
        0x1,
        0x1
    }
    l = {
        0x98,
        0xa0
    }
    m = "invokeSuspend"
    n = {
        "data",
        "i"
    }
    s = {
        "L$0",
        "I$0"
    }
.end annotation


# instance fields
.field final synthetic $extra:Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;

.field final synthetic $libScenes:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $sceneId:Ljava/lang/String;

.field final synthetic $sn:Ljava/lang/String;

.field I$0:I

.field I$1:I

.field L$0:Ljava/lang/Object;

.field label:I


# direct methods
.method constructor <init>(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;Ljava/lang/String;Ljava/util/ArrayList;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;",
            "Ljava/lang/String;",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$sceneId:Ljava/lang/String;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$extra:Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$sn:Ljava/lang/String;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$libScenes:Ljava/util/ArrayList;

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

    new-instance v6, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$sceneId:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$extra:Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$sn:Ljava/lang/String;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$libScenes:Ljava/util/ArrayList;

    move-object v0, v6

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;-><init>(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;Ljava/lang/String;Ljava/util/ArrayList;Lkotlin/coroutines/Continuation;)V

    check-cast v6, Lkotlin/coroutines/Continuation;

    return-object v6
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 20

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 151
    move-object/from16 v1, p0

    iget v2, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->label:I

    const-string v3, "OfflineRecgManger"

    const/4 v4, 0x1

    packed-switch v2, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v2, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    move-object/from16 v2, p0

    .local v2, "this":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;
    move-object/from16 v5, p1

    .local v5, "$result":Ljava/lang/Object;
    iget v6, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->I$1:I

    iget v7, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->I$0:I

    .local v7, "i":I
    iget-object v8, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->L$0:Ljava/lang/Object;

    check-cast v8, Ljava/util/List;

    .local v8, "data":Ljava/util/List;
    invoke-static {v5}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v18, v8

    move v8, v7

    move v7, v6

    move-object v6, v5

    goto/16 :goto_5

    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;
    .end local v5    # "$result":Ljava/lang/Object;
    .end local v7    # "i":I
    .end local v8    # "data":Ljava/util/List;
    :pswitch_1
    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;
    move-object/from16 v5, p1

    .restart local v5    # "$result":Ljava/lang/Object;
    invoke-static {v5}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v6, v5

    check-cast v6, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->unbox-impl()Ljava/lang/Object;

    move-result-object v6

    goto :goto_0

    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;
    .end local v5    # "$result":Ljava/lang/Object;
    :pswitch_2
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;
    move-object/from16 v5, p1

    .line 152
    .restart local v5    # "$result":Ljava/lang/Object;
    new-instance v6, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1$ret$1;

    iget-object v7, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$sn:Ljava/lang/String;

    iget-object v8, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$libScenes:Ljava/util/ArrayList;

    invoke-direct {v6, v7, v8}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1$ret$1;-><init>(Ljava/lang/String;Ljava/util/ArrayList;)V

    check-cast v6, Lkotlin/jvm/functions/Function0;

    move-object v7, v2

    check-cast v7, Lkotlin/coroutines/Continuation;

    iput v4, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->label:I

    invoke-static {v6, v7}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt;->api2Call(Lkotlin/jvm/functions/Function0;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v6

    if-ne v6, v0, :cond_0

    .line 151
    return-object v0

    .line 152
    :cond_0
    :goto_0
    nop

    .line 155
    .local v6, "ret":Ljava/lang/Object;
    invoke-static {v6}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isSuccess-impl(Ljava/lang/Object;)Z

    move-result v7

    const/4 v8, 0x0

    if-eqz v7, :cond_8

    .line 156
    const/4 v7, 0x0

    .line 362
    .local v7, "$i$f$getOrNull-impl":I
    nop

    .line 363
    invoke-static {v6}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    move-object v6, v8

    goto :goto_1

    .line 364
    :cond_1
    nop

    .line 365
    .end local v6    # "ret":Ljava/lang/Object;
    :goto_1
    nop

    .line 156
    .end local v7    # "$i$f$getOrNull-impl":I
    check-cast v6, Ljava/util/List;

    .line 157
    .local v6, "data":Ljava/util/List;
    move-object v7, v6

    check-cast v7, Ljava/util/Collection;

    if-eqz v7, :cond_3

    invoke-interface {v7}, Ljava/util/Collection;->isEmpty()Z

    move-result v7

    if-eqz v7, :cond_2

    goto :goto_2

    :cond_2
    const/4 v7, 0x0

    goto :goto_3

    :cond_3
    :goto_2
    move v7, v4

    :goto_3
    if-nez v7, :cond_7

    .line 158
    const/4 v7, 0x0

    .local v7, "i":I
    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v8

    move/from16 v19, v8

    move-object v8, v6

    move/from16 v6, v19

    .end local v6    # "data":Ljava/util/List;
    .restart local v8    # "data":Ljava/util/List;
    :goto_4
    if-ge v7, v6, :cond_c

    .line 159
    invoke-interface {v8, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;

    .line 160
    .local v9, "item":Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;
    sget-object v10, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

    iget-object v11, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$sceneId:Ljava/lang/String;

    iget-object v12, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$extra:Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;

    move-object v13, v2

    check-cast v13, Lkotlin/coroutines/Continuation;

    iput-object v8, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->L$0:Ljava/lang/Object;

    iput v7, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->I$0:I

    iput v6, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->I$1:I

    const/4 v14, 0x2

    iput v14, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->label:I

    invoke-static {v10, v11, v9, v12, v13}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->access$checkVersion(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v9

    .end local v9    # "item":Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;
    if-ne v9, v0, :cond_4

    .line 151
    return-object v0

    .line 160
    :cond_4
    move-object/from16 v18, v8

    move v8, v7

    move v7, v6

    move-object v6, v5

    move-object v5, v9

    .end local v5    # "$result":Ljava/lang/Object;
    .end local v7    # "i":I
    .local v6, "$result":Ljava/lang/Object;
    .local v8, "i":I
    .local v18, "data":Ljava/util/List;
    :goto_5
    check-cast v5, Ljava/lang/Boolean;

    invoke-virtual {v5}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v5

    .line 161
    .local v5, "ret":Z
    if-nez v5, :cond_5

    .line 162
    .end local v5    # "ret":Z
    .end local v8    # "i":I
    .end local v18    # "data":Ljava/util/List;
    sget-object v9, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

    iget-object v11, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$sn:Ljava/lang/String;

    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$extra:Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->getSceneId()Ljava/lang/String;

    move-result-object v12

    const/16 v16, 0x8

    const/16 v17, 0x0

    const/4 v10, 0x0

    const/4 v13, 0x0

    const/4 v14, -0x3

    const-string/jumbo v15, "\u4e0b\u8f7d\u5e03\u63a7\u5305\u5931\u8d25"

    invoke-static/range {v9 .. v17}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->sendCheckResponse$default(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;ZLjava/lang/String;Ljava/lang/String;Ljava/util/List;ILjava/lang/String;ILjava/lang/Object;)V

    .line 163
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    .line 165
    .restart local v8    # "i":I
    .restart local v18    # "data":Ljava/util/List;
    :cond_5
    invoke-interface/range {v18 .. v18}, Ljava/util/List;->size()I

    move-result v5

    sub-int/2addr v5, v4

    if-ne v8, v5, :cond_6

    .line 166
    const-string v5, "getPersonnelLib  CheckUpdate Complete "

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v3, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 167
    sget-object v9, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

    iget-object v11, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$sn:Ljava/lang/String;

    iget-object v5, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$extra:Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->getSceneId()Ljava/lang/String;

    move-result-object v12

    const/16 v16, 0x30

    const/16 v17, 0x0

    const/4 v10, 0x1

    const/4 v14, 0x0

    const/4 v15, 0x0

    move-object/from16 v13, v18

    invoke-static/range {v9 .. v17}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->sendCheckResponse$default(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;ZLjava/lang/String;Ljava/lang/String;Ljava/util/List;ILjava/lang/String;ILjava/lang/Object;)V

    .line 158
    :cond_6
    add-int/lit8 v5, v8, 0x1

    move-object/from16 v8, v18

    move/from16 v19, v7

    move v7, v5

    move-object v5, v6

    move/from16 v6, v19

    .end local v8    # "i":I
    .local v5, "i":I
    goto :goto_4

    .line 171
    .end local v18    # "data":Ljava/util/List;
    .local v5, "$result":Ljava/lang/Object;
    .local v6, "data":Ljava/util/List;
    :cond_7
    sget-object v8, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

    iget-object v10, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$sn:Ljava/lang/String;

    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$extra:Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->getSceneId()Ljava/lang/String;

    move-result-object v11

    const/16 v15, 0x8

    const/16 v16, 0x0

    const/4 v9, 0x0

    const/4 v12, 0x0

    const/4 v13, -0x4

    const-string/jumbo v14, "\u672a\u914d\u7f6e\u79bb\u7ebf\u5e03\u63a7\u5305"

    invoke-static/range {v8 .. v16}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->sendCheckResponse$default(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;ZLjava/lang/String;Ljava/lang/String;Ljava/util/List;ILjava/lang/String;ILjava/lang/Object;)V

    .line 172
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getPersonnelLib Fail - data = "

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v4, 0x20

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    .end local v6    # "data":Ljava/util/List;
    invoke-static {v3, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_6

    .line 175
    .local v6, "ret":Ljava/lang/Object;
    :cond_8
    sget-object v9, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

    iget-object v11, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$sn:Ljava/lang/String;

    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->$extra:Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->getSceneId()Ljava/lang/String;

    move-result-object v12

    invoke-static {v6}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->exceptionOrNull-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    move-result-object v0

    if-eqz v0, :cond_9

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;->getMessage()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_a

    :cond_9
    const-string/jumbo v0, "\u63a5\u53e3\u8c03\u7528\u5931\u8d25"

    :cond_a
    move-object v15, v0

    const/16 v16, 0x8

    const/16 v17, 0x0

    const/4 v10, 0x0

    const/4 v13, 0x0

    const/4 v14, -0x1

    invoke-static/range {v9 .. v17}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->sendCheckResponse$default(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;ZLjava/lang/String;Ljava/lang/String;Ljava/util/List;ILjava/lang/String;ILjava/lang/Object;)V

    .line 176
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getPersonnelLib Fail - error message = "

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {v6}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->exceptionOrNull-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    move-result-object v4

    .end local v6    # "ret":Ljava/lang/Object;
    if-eqz v4, :cond_b

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;->getMessage()Ljava/lang/String;

    move-result-object v8

    :cond_b
    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v3, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 178
    :cond_c
    :goto_6
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
