.class final Lcom/rokid/phone/DeviceLinkerManager$saveResult$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "DeviceLinkerManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/phone/DeviceLinkerManager;->saveResult(Lcom/rokid/phone/ai/AiVisionRelayPayload;[B)V
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
    value = "SMAP\nDeviceLinkerManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 DeviceLinkerManager.kt\ncom/rokid/phone/DeviceLinkerManager$saveResult$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,300:1\n827#2:301\n855#2,2:302\n1#3:304\n*S KotlinDebug\n*F\n+ 1 DeviceLinkerManager.kt\ncom/rokid/phone/DeviceLinkerManager$saveResult$1\n*L\n283#1:301\n283#1:302,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0010\u0002\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u0001*\u00020\u0002H\n"
    }
    d2 = {
        "<anonymous>",
        "",
        "Lkotlinx/coroutines/CoroutineScope;"
    }
    k = 0x3
    mv = {
        0x2,
        0x2,
        0x0
    }
    xi = 0x30
.end annotation

.annotation runtime Lkotlin/coroutines/jvm/internal/DebugMetadata;
    c = "com.rokid.phone.DeviceLinkerManager$saveResult$1"
    f = "DeviceLinkerManager.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $data:[B

.field final synthetic $payload:Lcom/rokid/phone/ai/AiVisionRelayPayload;

.field private synthetic L$0:Ljava/lang/Object;

.field label:I


# direct methods
.method constructor <init>(Lcom/rokid/phone/ai/AiVisionRelayPayload;[BLkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/phone/ai/AiVisionRelayPayload;",
            "[B",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/phone/DeviceLinkerManager$saveResult$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/phone/DeviceLinkerManager$saveResult$1;->$payload:Lcom/rokid/phone/ai/AiVisionRelayPayload;

    iput-object p2, p0, Lcom/rokid/phone/DeviceLinkerManager$saveResult$1;->$data:[B

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

    new-instance v0, Lcom/rokid/phone/DeviceLinkerManager$saveResult$1;

    iget-object v1, p0, Lcom/rokid/phone/DeviceLinkerManager$saveResult$1;->$payload:Lcom/rokid/phone/ai/AiVisionRelayPayload;

    iget-object v2, p0, Lcom/rokid/phone/DeviceLinkerManager$saveResult$1;->$data:[B

    invoke-direct {v0, v1, v2, p2}, Lcom/rokid/phone/DeviceLinkerManager$saveResult$1;-><init>(Lcom/rokid/phone/ai/AiVisionRelayPayload;[BLkotlin/coroutines/Continuation;)V

    iput-object p1, v0, Lcom/rokid/phone/DeviceLinkerManager$saveResult$1;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/phone/DeviceLinkerManager$saveResult$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/phone/DeviceLinkerManager$saveResult$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/DeviceLinkerManager$saveResult$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/phone/DeviceLinkerManager$saveResult$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 25
    .param p1, "$result"    # Ljava/lang/Object;

    move-object/from16 v1, p0

    iget-object v0, v1, Lcom/rokid/phone/DeviceLinkerManager$saveResult$1;->L$0:Ljava/lang/Object;

    move-object v2, v0

    check-cast v2, Lkotlinx/coroutines/CoroutineScope;

    .local v2, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 260
    iget v0, v1, Lcom/rokid/phone/DeviceLinkerManager$saveResult$1;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    .line 261
    iget-object v0, v1, Lcom/rokid/phone/DeviceLinkerManager$saveResult$1;->$payload:Lcom/rokid/phone/ai/AiVisionRelayPayload;

    iget-object v3, v1, Lcom/rokid/phone/DeviceLinkerManager$saveResult$1;->$data:[B

    :try_start_0
    sget-object v4, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v4, v2

    .local v4, "$this$invokeSuspend_u24lambda_u242":Lkotlinx/coroutines/CoroutineScope;
    const/4 v5, 0x0

    .line 262
    .local v5, "$i$a$-runCatching-DeviceLinkerManager$saveResult$1$1":I
    sget-object v6, Lcom/rokid/phone/MyApplication;->Companion:Lcom/rokid/phone/MyApplication$Companion;

    invoke-virtual {v6}, Lcom/rokid/phone/MyApplication$Companion;->getInstance()Lcom/rokid/phone/MyApplication;

    move-result-object v6

    .line 263
    .local v6, "context":Lcom/rokid/phone/MyApplication;
    const-string v7, "receiver"

    invoke-virtual {v6, v7}, Lcom/rokid/phone/MyApplication;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v7

    if-eqz v7, :cond_2

    .line 264
    .local v7, "directory":Ljava/io/File;
    invoke-virtual {v7}, Ljava/io/File;->mkdirs()Z

    .line 265
    new-instance v8, Ljava/io/File;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "image-"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v0}, Lcom/rokid/phone/ai/AiVisionRelayPayload;->getTimestamp()J

    move-result-wide v10

    invoke-virtual {v9, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v9

    const/16 v10, 0x2d

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v0}, Lcom/rokid/phone/ai/AiVisionRelayPayload;->getQuestionId()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ".jpg"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v7, v9}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 266
    .local v8, "file":Ljava/io/File;
    invoke-static {v8, v3}, Lkotlin/io/FilesKt;->writeBytes(Ljava/io/File;[B)V

    .line 268
    move-object v3, v6

    check-cast v3, Landroid/content/Context;

    .line 269
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6}, Lcom/rokid/phone/MyApplication;->getPackageName()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ".fileprovider"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    .line 270
    nop

    .line 267
    invoke-static {v3, v9, v8}, Landroidx/core/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object v3

    .line 271
    invoke-virtual {v3}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v9

    const-string v3, "toString(...)"

    invoke-static {v9, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v10, "content:"

    const-string v11, "https:"

    const/4 v13, 0x4

    const/4 v14, 0x0

    const/4 v12, 0x0

    invoke-static/range {v9 .. v14}, Lkotlin/text/StringsKt;->replaceFirst$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v21

    .line 267
    nop

    .line 272
    .local v21, "imageUri":Ljava/lang/String;
    new-instance v3, Lcom/rokid/phone/ai/AiVisionRecord;

    .line 273
    invoke-virtual {v0}, Lcom/rokid/phone/ai/AiVisionRelayPayload;->getQuestionId()Ljava/lang/String;

    move-result-object v16

    .line 274
    invoke-virtual {v0}, Lcom/rokid/phone/ai/AiVisionRelayPayload;->getQuestion()Ljava/lang/String;

    move-result-object v17

    .line 275
    invoke-virtual {v0}, Lcom/rokid/phone/ai/AiVisionRelayPayload;->getAnswer()Ljava/lang/String;

    move-result-object v18

    .line 276
    invoke-virtual {v0}, Lcom/rokid/phone/ai/AiVisionRelayPayload;->getReportTitle()Ljava/lang/String;

    move-result-object v19

    .line 277
    invoke-virtual {v0}, Lcom/rokid/phone/ai/AiVisionRelayPayload;->getReportSummary()Ljava/lang/String;

    move-result-object v20

    .line 278
    nop

    .line 279
    invoke-virtual {v0}, Lcom/rokid/phone/ai/AiVisionRelayPayload;->getTimestamp()J

    move-result-wide v22

    .line 280
    nop

    .line 272
    const/16 v24, 0x1

    move-object v15, v3

    invoke-direct/range {v15 .. v24}, Lcom/rokid/phone/ai/AiVisionRecord;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JZ)V

    move-object v0, v3

    .line 282
    .local v0, "record":Lcom/rokid/phone/ai/AiVisionRecord;
    sget-object v3, Lcom/rokid/phone/ai/AiVisionStore;->INSTANCE:Lcom/rokid/phone/ai/AiVisionStore;

    move-object v9, v6

    check-cast v9, Landroid/content/Context;

    invoke-virtual {v3, v9}, Lcom/rokid/phone/ai/AiVisionStore;->load(Landroid/content/Context;)Ljava/util/List;

    move-result-object v3

    check-cast v3, Ljava/lang/Iterable;

    .line 283
    nop

    .local v3, "$this$filterNot$iv":Ljava/lang/Iterable;
    const/4 v9, 0x0

    .line 301
    .local v9, "$i$f$filterNot":I
    new-instance v10, Ljava/util/ArrayList;

    invoke-direct {v10}, Ljava/util/ArrayList;-><init>()V

    check-cast v10, Ljava/util/Collection;

    .local v10, "destination$iv$iv":Ljava/util/Collection;
    move-object v11, v3

    .local v11, "$this$filterNotTo$iv$iv":Ljava/lang/Iterable;
    const/4 v12, 0x0

    .line 302
    .local v12, "$i$f$filterNotTo":I
    invoke-interface {v11}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v13

    :goto_0
    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v14

    if-eqz v14, :cond_1

    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v14

    .local v14, "element$iv$iv":Ljava/lang/Object;
    move-object v15, v14

    check-cast v15, Lcom/rokid/phone/ai/AiVisionRecord;

    .local v15, "it":Lcom/rokid/phone/ai/AiVisionRecord;
    const/16 v16, 0x0

    .line 283
    .local v16, "$i$a$-filterNot-DeviceLinkerManager$saveResult$1$1$records$1":I
    invoke-virtual {v15}, Lcom/rokid/phone/ai/AiVisionRecord;->getQuestionId()Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-object/from16 v17, v2

    .end local v2    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local v17, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_1
    invoke-virtual {v0}, Lcom/rokid/phone/ai/AiVisionRecord;->getQuestionId()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    .line 302
    .end local v15    # "it":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local v16    # "$i$a$-filterNot-DeviceLinkerManager$saveResult$1$1$records$1":I
    if-nez v1, :cond_0

    invoke-interface {v10, v14}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    :cond_0
    move-object/from16 v1, p0

    move-object/from16 v2, v17

    goto :goto_0

    .line 303
    .end local v14    # "element$iv$iv":Ljava/lang/Object;
    .end local v17    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v2    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :cond_1
    move-object/from16 v17, v2

    .end local v2    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v10    # "destination$iv$iv":Ljava/util/Collection;
    .end local v11    # "$this$filterNotTo$iv$iv":Ljava/lang/Iterable;
    .end local v12    # "$i$f$filterNotTo":I
    .restart local v17    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    move-object v1, v10

    check-cast v1, Ljava/util/List;

    .line 301
    nop

    .end local v3    # "$this$filterNot$iv":Ljava/lang/Iterable;
    .end local v9    # "$i$f$filterNot":I
    check-cast v1, Ljava/util/Collection;

    .line 284
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->toMutableList(Ljava/util/Collection;)Ljava/util/List;

    move-result-object v1

    .line 285
    move-object v2, v1

    .line 304
    .local v2, "$this$invokeSuspend_u24lambda_u242_u24lambda_u241":Ljava/util/List;
    const/4 v3, 0x0

    .line 285
    .local v3, "$i$a$-apply-DeviceLinkerManager$saveResult$1$1$records$2":I
    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 282
    .end local v2    # "$this$invokeSuspend_u24lambda_u242_u24lambda_u241":Ljava/util/List;
    .end local v3    # "$i$a$-apply-DeviceLinkerManager$saveResult$1$1$records$2":I
    nop

    .line 286
    .local v1, "records":Ljava/util/List;
    sget-object v2, Lcom/rokid/phone/ai/AiVisionStore;->INSTANCE:Lcom/rokid/phone/ai/AiVisionStore;

    move-object v3, v6

    check-cast v3, Landroid/content/Context;

    move-object v9, v1

    check-cast v9, Ljava/util/Collection;

    invoke-virtual {v2, v3, v9}, Lcom/rokid/phone/ai/AiVisionStore;->save(Landroid/content/Context;Ljava/util/Collection;)V

    .line 287
    nop

    .line 288
    new-instance v2, Landroid/content/Intent;

    const-string v3, "com.rokid.phone.action.AI_VISION_RECORDS_UPDATED"

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6}, Lcom/rokid/phone/MyApplication;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v2

    .line 287
    invoke-virtual {v6, v2}, Lcom/rokid/phone/MyApplication;->sendBroadcast(Landroid/content/Intent;)V

    .line 290
    nop

    .end local v0    # "record":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local v1    # "records":Ljava/util/List;
    .end local v4    # "$this$invokeSuspend_u24lambda_u242":Lkotlinx/coroutines/CoroutineScope;
    .end local v5    # "$i$a$-runCatching-DeviceLinkerManager$saveResult$1$1":I
    .end local v6    # "context":Lcom/rokid/phone/MyApplication;
    .end local v7    # "directory":Ljava/io/File;
    .end local v8    # "file":Ljava/io/File;
    .end local v21    # "imageUri":Ljava/lang/String;
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 261
    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_2

    .line 263
    .end local v17    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local v2, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v4    # "$this$invokeSuspend_u24lambda_u242":Lkotlinx/coroutines/CoroutineScope;
    .restart local v5    # "$i$a$-runCatching-DeviceLinkerManager$saveResult$1$1":I
    .restart local v6    # "context":Lcom/rokid/phone/MyApplication;
    :cond_2
    move-object/from16 v17, v2

    .end local v2    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v17    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "receiver directory unavailable"

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local v17    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local p1    # "$result":Ljava/lang/Object;
    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 261
    .end local v4    # "$this$invokeSuspend_u24lambda_u242":Lkotlinx/coroutines/CoroutineScope;
    .end local v5    # "$i$a$-runCatching-DeviceLinkerManager$saveResult$1$1":I
    .end local v6    # "context":Lcom/rokid/phone/MyApplication;
    .restart local v17    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local p1    # "$result":Ljava/lang/Object;
    :catchall_0
    move-exception v0

    goto :goto_1

    .end local v17    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v2    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catchall_1
    move-exception v0

    move-object/from16 v17, v2

    .end local v2    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v17    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :goto_1
    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v0}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 290
    :goto_2
    invoke-static {v0}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v0

    if-eqz v0, :cond_3

    .local v0, "it":Ljava/lang/Throwable;
    const/4 v1, 0x0

    .line 291
    .local v1, "$i$a$-onFailure-DeviceLinkerManager$saveResult$1$2":I
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "save AI vision result failed: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "DeviceLinkerManager"

    invoke-static {v3, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 292
    nop

    .line 290
    .end local v0    # "it":Ljava/lang/Throwable;
    .end local v1    # "$i$a$-onFailure-DeviceLinkerManager$saveResult$1$2":I
    nop

    .line 293
    :cond_3
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
