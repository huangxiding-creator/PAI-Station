.class public final Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1;
.super Ljava/lang/Object;
.source "InspectionServiceImpl.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nInspectionServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 InspectionServiceImpl.kt\ncom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,894:1\n1#2:895\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000/\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0010\u0008\n\u0002\u0008\u0005*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0007H\u0016J\u0010\u0010\u0008\u001a\u00020\u00032\u0006\u0010\t\u001a\u00020\nH\u0017J \u0010\u000b\u001a\u00020\u00032\u0006\u0010\u000c\u001a\u00020\u00072\u0006\u0010\r\u001a\u00020\u000e2\u0006\u0010\u000f\u001a\u00020\u000eH\u0016J\u0010\u0010\u0010\u001a\u00020\u00032\u0006\u0010\t\u001a\u00020\nH\u0016J\u0010\u0010\u0011\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J \u0010\u0012\u001a\u00020\u00032\u0006\u0010\u000c\u001a\u00020\u00072\u0006\u0010\r\u001a\u00020\u000e2\u0006\u0010\u000f\u001a\u00020\u000eH\u0002\u00a8\u0006\u0013"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;",
        "onAudioStream",
        "",
        "buffer",
        "Ljava/nio/ByteBuffer;",
        "onClassicBTAudioStream",
        "",
        "onClassicBTTextMessage",
        "msg",
        "",
        "onNv21Data",
        "data",
        "width",
        "",
        "height",
        "onP2PTextMessage",
        "onVideoH264Stream",
        "startRecord",
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


# direct methods
.method public static synthetic $r8$lambda$Ph-IGN_aQC_3tkXlOkt92xi9Y6I([BIILjava/lang/String;)V
    .locals 0

    invoke-static {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1;->onNv21Data$lambda$3([BIILjava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$_QVQrpOAjmSo1mI0T08cApX7PFE([BIILjava/lang/String;)V
    .locals 0

    invoke-static {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1;->onNv21Data$lambda$2([BIILjava/lang/String;)V

    return-void
.end method

.method constructor <init>()V
    .locals 0

    .line 311
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static final onNv21Data$lambda$2([BIILjava/lang/String;)V
    .locals 20
    .param p0, "$data"    # [B
    .param p1, "$width"    # I
    .param p2, "$height"    # I
    .param p3, "$currentTaskId"    # Ljava/lang/String;

    move-object/from16 v1, p0

    const-string v2, "InspectionServiceImpl"

    const-string v0, "$data"

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "$currentTaskId"

    move-object/from16 v10, p3

    invoke-static {v10, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 358
    nop

    .line 359
    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    move-wide v11, v3

    .line 360
    .local v11, "timestamp":J
    new-instance v0, Ljava/io/File;

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getGuideSessionDir$p()Ljava/io/File;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v11, v12}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ".jpg"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v0, v3, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 361
    .local v0, "outputFile":Ljava/io/File;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "take picture -> "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 362
    sget-object v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move/from16 v13, p1

    move/from16 v14, p2

    :try_start_1
    invoke-static {v3, v1, v13, v14, v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$nv21ToJpeg(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;[BIILjava/io/File;)Ljava/io/File;

    move-result-object v3

    move-object v15, v3

    .line 363
    .local v15, "saved":Ljava/io/File;
    if-eqz v15, :cond_2

    .line 364
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getGuideSessionDir$p()Ljava/io/File;

    move-result-object v3

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v3}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v3

    move-object v8, v3

    .line 365
    .local v8, "subfolderName":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v15}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    const-string/jumbo v5, "saved.absolutePath"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$containsFilePath(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 367
    invoke-virtual {v15}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    .line 371
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v16

    .line 366
    new-instance v18, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;

    .line 367
    const-string v3, "absolutePath"

    invoke-static {v4, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 370
    const-string v5, ""

    .line 369
    nop

    .line 368
    const-string v7, ""

    .line 371
    nop

    .line 366
    move-object/from16 v3, v18

    move-object/from16 v6, p3

    move-object/from16 v19, v0

    move-object v0, v8

    .end local v8    # "subfolderName":Ljava/lang/String;
    .local v0, "subfolderName":Ljava/lang/String;
    .local v19, "outputFile":Ljava/io/File;
    move-wide/from16 v8, v16

    invoke-direct/range {v3 .. v9}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    move-object/from16 v3, v18

    .line 374
    .local v3, "newInspectDataInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getInspectionDataManager$p()Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

    move-result-object v4

    if-nez v4, :cond_0

    const-string v4, "inspectionDataManager"

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v4, 0x0

    :cond_0
    const-string/jumbo v5, "subfolderName"

    invoke-static {v0, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v4, v0, v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->addInspectInfo(Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;)V

    .end local v3    # "newInspectDataInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    goto :goto_1

    .line 376
    .end local v19    # "outputFile":Ljava/io/File;
    .local v0, "outputFile":Ljava/io/File;
    .restart local v8    # "subfolderName":Ljava/lang/String;
    :cond_1
    move-object/from16 v19, v0

    move-object v0, v8

    .end local v8    # "subfolderName":Ljava/lang/String;
    .local v0, "subfolderName":Ljava/lang/String;
    .restart local v19    # "outputFile":Ljava/io/File;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "skip duplicate picture entry: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v15}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 379
    .end local v19    # "outputFile":Ljava/io/File;
    .local v0, "outputFile":Ljava/io/File;
    :cond_2
    move-object/from16 v19, v0

    .end local v0    # "outputFile":Ljava/io/File;
    .restart local v19    # "outputFile":Ljava/io/File;
    const-string/jumbo v0, "take picture failed: nv21ToJpeg returned null"

    invoke-static {v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    .line 381
    .end local v11    # "timestamp":J
    .end local v15    # "saved":Ljava/io/File;
    .end local v19    # "outputFile":Ljava/io/File;
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    move/from16 v13, p1

    move/from16 v14, p2

    .line 382
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    const-string/jumbo v3, "take picture exception"

    move-object v4, v0

    check-cast v4, Ljava/lang/Throwable;

    invoke-static {v2, v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 384
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method private static final onNv21Data$lambda$3([BIILjava/lang/String;)V
    .locals 17
    .param p0, "$data"    # [B
    .param p1, "$width"    # I
    .param p2, "$height"    # I
    .param p3, "$curTask"    # Ljava/lang/String;

    move-object/from16 v0, p0

    const-string v1, "$data"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v1, "$curTask"

    move-object/from16 v9, p3

    invoke-static {v9, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 394
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v10

    .line 395
    .local v10, "timestamp":J
    new-instance v1, Ljava/io/File;

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getGuideSessionDir$p()Ljava/io/File;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "_offline.jpg"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 396
    .local v1, "outputFile":Ljava/io/File;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    move/from16 v12, p1

    move/from16 v13, p2

    invoke-static {v2, v0, v12, v13, v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$nv21ToJpeg(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;[BIILjava/io/File;)Ljava/io/File;

    move-result-object v14

    .line 397
    .local v14, "saved":Ljava/io/File;
    if-eqz v14, :cond_2

    .line 398
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v14}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    const-string/jumbo v4, "saved.absolutePath"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v2, v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->setOfflineImagePath(Ljava/lang/String;)V

    .line 399
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getGuideSessionDir$p()Ljava/io/File;

    move-result-object v2

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v15

    .line 400
    .local v15, "subfolderName":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v14}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$containsFilePath(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 402
    invoke-virtual {v14}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    .line 406
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    .line 401
    new-instance v16, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;

    .line 402
    const-string v2, "absolutePath"

    invoke-static {v3, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 405
    nop

    .line 404
    nop

    .line 403
    nop

    .line 406
    nop

    .line 401
    const-string v4, ""

    const-string v6, ""

    move-object/from16 v2, v16

    move-object/from16 v5, p3

    invoke-direct/range {v2 .. v8}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    .line 408
    .local v2, "newInspectDataInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getInspectionDataManager$p()Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

    move-result-object v3

    if-nez v3, :cond_0

    const-string v3, "inspectionDataManager"

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v3, 0x0

    :cond_0
    const-string/jumbo v4, "subfolderName"

    invoke-static {v15, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v3, v15, v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->addInspectInfo(Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;)V

    .end local v2    # "newInspectDataInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    goto :goto_0

    .line 410
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "skip duplicate offline picture entry: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v14}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "InspectionServiceImpl"

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 413
    .end local v15    # "subfolderName":Ljava/lang/String;
    :cond_2
    :goto_0
    return-void
.end method

.method private final startRecord([BII)V
    .locals 5
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I

    .line 331
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getRecorderLock$p()Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    const/4 v1, 0x0

    .line 332
    .local v1, "$i$a$-synchronized-InspectionServiceImpl$mInterMessageListener$1$startRecord$1":I
    :try_start_0
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getRecorder$p()Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;

    move-result-object v2

    if-nez v2, :cond_0

    .line 333
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->setPiceVideoTime(J)V

    .line 334
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    new-instance v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;

    invoke-static {}, Lcom/rokid/utils/ContextUtil;->getApplicationContext()Landroid/app/Application;

    move-result-object v3

    const-string v4, "getApplicationContext()"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v3, Landroid/content/Context;

    invoke-direct {v2, v3, p2, p3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;-><init>(Landroid/content/Context;II)V

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$setRecorder$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;)V

    .line 336
    :cond_0
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$isInspect$p()Z

    move-result v2

    if-nez v2, :cond_1

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$isGlobalRecording$p()Z

    move-result v2

    if-nez v2, :cond_1

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getPiceRecord$p()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 337
    :cond_1
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getRecorder$p()Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;

    move-result-object v2

    if-eqz v2, :cond_2

    invoke-virtual {v2, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->encodeVideoFrame([B)V

    .line 339
    :cond_2
    nop

    .end local v1    # "$i$a$-synchronized-InspectionServiceImpl$mInterMessageListener$1$startRecord$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 331
    monitor-exit v0

    .line 340
    return-void

    .line 331
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method


# virtual methods
.method public onAudioStream(Ljava/nio/ByteBuffer;)V
    .locals 2
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 321
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$isGlobalRecording$p()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getPiceRecord$p()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$isInspect$p()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 322
    :cond_0
    nop

    .line 323
    :try_start_0
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    new-array v0, v0, [B

    .line 324
    .local v0, "pcm":[B
    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 325
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getRecorder$p()Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {v1, v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->encodeAudioFrame([B)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 326
    .end local v0    # "pcm":[B
    :catch_0
    move-exception v0

    .line 328
    :cond_1
    :goto_0
    return-void
.end method

.method public onBTStreamDataReceived(Ljava/lang/String;[BLjava/lang/String;)V
    .locals 0
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    .line 311
    invoke-static {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onBTStreamDataReceived(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/lang/String;[BLjava/lang/String;)V

    return-void
.end method

.method public onBleTextMessage(Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;

    .line 311
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onBleTextMessage(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/lang/String;)V

    return-void
.end method

.method public onClassicBTAudioStream([B)V
    .locals 2
    .param p1, "buffer"    # [B

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 418
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$isGlobalRecording$p()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getPiceRecord$p()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$isInspect$p()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 419
    :cond_0
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getRecorder$p()Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->encodeAudioFrame([B)V

    .line 422
    :cond_1
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isOfflineRecord()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 423
    const-string v0, "InspectionServiceImpl"

    const-string v1, " offlineRecorder?.write(buffer)"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 424
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getOfflineRecorder$p()Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->write([B)V

    .line 426
    :cond_2
    return-void
.end method

.method public onClassicBTTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 431
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->onMessage(Ljava/lang/String;)V

    .line 432
    return-void
.end method

.method public onNv21Data([BII)V
    .locals 4
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 345
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$isGlobalRecording$p()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 346
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1;->startRecord([BII)V

    .line 348
    :cond_0
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$isGlobalRecording$p()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getPiceRecord$p()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 349
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1;->startRecord([BII)V

    .line 352
    :cond_1
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-static {v0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$qrCodeAnalyzer(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;[BII)V

    .line 355
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getGuideSessionDir$p()Ljava/io/File;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_4

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getPendingTakePicture$p()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    const/4 v2, 0x1

    invoke-virtual {v0, v2, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 356
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getTakePictureId$p()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v3

    if-nez v3, :cond_2

    goto :goto_0

    :cond_2
    move v2, v1

    :goto_0
    if-eqz v2, :cond_3

    .line 895
    const/4 v0, 0x0

    .line 356
    .local v0, "$i$a$-ifEmpty-InspectionServiceImpl$mInterMessageListener$1$onNv21Data$currentTaskId$1":I
    nop

    .end local v0    # "$i$a$-ifEmpty-InspectionServiceImpl$mInterMessageListener$1$onNv21Data$currentTaskId$1":I
    const-string v0, "ext"

    :cond_3
    check-cast v0, Ljava/lang/String;

    .line 357
    .local v0, "currentTaskId":Ljava/lang/String;
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getPictureWorker$p()Ljava/util/concurrent/ExecutorService;

    move-result-object v2

    new-instance v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1$$ExternalSyntheticLambda0;

    invoke-direct {v3, p1, p2, p3, v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1$$ExternalSyntheticLambda0;-><init>([BIILjava/lang/String;)V

    invoke-interface {v2, v3}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    .line 385
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    const-string v2, ""

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$setTakePictureId$p(Ljava/lang/String;)V

    .line 389
    .end local v0    # "currentTaskId":Ljava/lang/String;
    :cond_4
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getGuideSessionDir$p()Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_5

    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->getOfflineTakePictureFlag()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 391
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->setOfflineTakePictureFlag(Z)V

    .line 392
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->getOfflineTaskID()Ljava/lang/String;

    move-result-object v0

    .line 393
    .local v0, "curTask":Ljava/lang/String;
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getPictureWorker$p()Ljava/util/concurrent/ExecutorService;

    move-result-object v1

    new-instance v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1$$ExternalSyntheticLambda1;

    invoke-direct {v2, p1, p2, p3, v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1$$ExternalSyntheticLambda1;-><init>([BIILjava/lang/String;)V

    invoke-interface {v1, v2}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    .line 415
    .end local v0    # "curTask":Ljava/lang/String;
    :cond_5
    return-void
.end method

.method public onP2PTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 313
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->onMessage(Ljava/lang/String;)V

    .line 314
    return-void
.end method

.method public onVideoH264Stream(Ljava/nio/ByteBuffer;)V
    .locals 1
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 318
    return-void
.end method
