.class public final Lcom/rokid/security/phone/sdk/server/track/TrackManager$initLpr$1;
.super Ljava/lang/Object;
.source "TrackManager.kt"

# interfaces
.implements Lcom/rokid/aicore/api/callback/LPRCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/track/TrackManager;->initLpr()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nTrackManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 TrackManager.kt\ncom/rokid/security/phone/sdk/server/track/TrackManager$initLpr$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,411:1\n1855#2,2:412\n*S KotlinDebug\n*F\n+ 1 TrackManager.kt\ncom/rokid/security/phone/sdk/server/track/TrackManager$initLpr$1\n*L\n257#1:412,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000%\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J(\u0010\u0002\u001a\u00020\u00032\u0016\u0010\u0004\u001a\u0012\u0012\u0004\u0012\u00020\u00060\u0005j\u0008\u0012\u0004\u0012\u00020\u0006`\u00072\u0006\u0010\u0008\u001a\u00020\tH\u0016\u00a8\u0006\n"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/track/TrackManager$initLpr$1",
        "Lcom/rokid/aicore/api/callback/LPRCallback;",
        "onLPREvent",
        "",
        "recgLprResultArrayList",
        "Ljava/util/ArrayList;",
        "Lcom/rokid/aicore/api/callback/result/LPRResult;",
        "Lkotlin/collections/ArrayList;",
        "frame_id",
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
.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initLpr$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    .line 230
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLPREvent(Ljava/util/ArrayList;J)V
    .locals 20
    .param p1, "recgLprResultArrayList"    # Ljava/util/ArrayList;
    .param p2, "frame_id"    # J
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/result/LPRResult;",
            ">;J)V"
        }
    .end annotation

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    const-string v2, "recgLprResultArrayList"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 235
    move-object v2, v1

    check-cast v2, Ljava/util/Collection;

    invoke-interface {v2}, Ljava/util/Collection;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_6

    .line 236
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initLpr$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "#onLPREvent: recgLprResultArrayList.size = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual/range {p1 .. p1}, Ljava/util/ArrayList;->size()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 237
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initLpr$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    move-object v3, v1

    check-cast v3, Ljava/util/List;

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getBestLPRResult(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Ljava/util/List;)Lcom/rokid/aicore/api/callback/result/LPRResult;

    move-result-object v2

    if-eqz v2, :cond_7

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initLpr$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    .local v2, "it":Lcom/rokid/aicore/api/callback/result/LPRResult;
    const/4 v4, 0x0

    .line 238
    .local v4, "$i$a$-let-TrackManager$initLpr$1$onLPREvent$1":I
    invoke-virtual {v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getLabel()Ljava/lang/String;

    move-result-object v5

    check-cast v5, Ljava/lang/CharSequence;

    const/4 v6, 0x1

    const/4 v7, 0x0

    if-eqz v5, :cond_1

    invoke-interface {v5}, Ljava/lang/CharSequence;->length()I

    move-result v5

    if-nez v5, :cond_0

    goto :goto_0

    :cond_0
    move v5, v7

    goto :goto_1

    :cond_1
    :goto_0
    move v5, v6

    :goto_1
    if-eqz v5, :cond_4

    .line 239
    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/lang/String;

    move-result-object v3

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "#onLPREvent: getBestLPRResult result: "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v8, " or it.label.isNullOrEmpty(): "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getLabel()Ljava/lang/String;

    move-result-object v8

    check-cast v8, Ljava/lang/CharSequence;

    if-eqz v8, :cond_3

    invoke-interface {v8}, Ljava/lang/CharSequence;->length()I

    move-result v8

    if-nez v8, :cond_2

    goto :goto_2

    :cond_2
    move v6, v7

    :cond_3
    :goto_2
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v3, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    goto/16 :goto_4

    .line 241
    :cond_4
    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "#onLPREvent: getBestLPRResult : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " && ready lprRecgListener invoke "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 243
    sget v12, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->PREVIEW_WIDTH:I

    .line 244
    sget v13, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->PREVIEW_HEIGHT:I

    .line 245
    invoke-virtual {v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getData()[B

    move-result-object v14

    .line 246
    sget-object v5, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->Companion:Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion$Companion;

    .line 247
    new-instance v6, Landroid/graphics/RectF;

    invoke-virtual {v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getX1()F

    move-result v7

    invoke-virtual {v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getY1()F

    move-result v8

    invoke-virtual {v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getX2()F

    move-result v9

    invoke-virtual {v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getY2()F

    move-result v10

    invoke-direct {v6, v7, v8, v9, v10}, Landroid/graphics/RectF;-><init>(FFFF)V

    .line 248
    sget v7, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->PREVIEW_WIDTH:I

    .line 249
    sget v8, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->PREVIEW_HEIGHT:I

    .line 246
    invoke-virtual {v5, v6, v7, v8}, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion$Companion;->toRect(Landroid/graphics/RectF;II)Landroid/graphics/Rect;

    move-result-object v15

    .line 251
    invoke-virtual {v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getScore()F

    move-result v16

    .line 252
    invoke-virtual {v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getLabel()Ljava/lang/String;

    move-result-object v5

    .line 253
    invoke-virtual {v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getColor()Ljava/lang/String;

    move-result-object v6

    .line 254
    invoke-virtual {v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getFrameId()J

    move-result-wide v8

    .line 255
    invoke-virtual {v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getLabel_id()J

    move-result-wide v10

    .line 242
    new-instance v19, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;

    .line 254
    nop

    .line 255
    nop

    .line 243
    nop

    .line 244
    nop

    .line 245
    const-string v7, "data"

    invoke-static {v14, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 246
    nop

    .line 251
    nop

    .line 252
    const-string v7, "label"

    invoke-static {v5, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 253
    const-string v7, "color"

    invoke-static {v6, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 242
    move-object/from16 v7, v19

    move-object/from16 v17, v5

    move-object/from16 v18, v6

    invoke-direct/range {v7 .. v18}, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;-><init>(JJII[BLandroid/graphics/Rect;FLjava/lang/String;Ljava/lang/String;)V

    move-object/from16 v5, v19

    .line 257
    .local v5, "lPRModel":Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;
    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getMTrackListeners$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/util/Set;

    move-result-object v6

    check-cast v6, Ljava/lang/Iterable;

    .local v6, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v7, 0x0

    .line 412
    .local v7, "$i$f$forEach":I
    invoke-interface {v6}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :goto_3
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_5

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    .local v9, "element$iv":Ljava/lang/Object;
    move-object v10, v9

    check-cast v10, Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;

    .local v10, "it1":Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;
    const/4 v11, 0x0

    .line 258
    .local v11, "$i$a$-forEach-TrackManager$initLpr$1$onLPREvent$1$1":I
    invoke-interface {v10, v5}, Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;->onLPRTrack(Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;)V

    .line 259
    nop

    .line 412
    .end local v10    # "it1":Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;
    .end local v11    # "$i$a$-forEach-TrackManager$initLpr$1$onLPREvent$1$1":I
    nop

    .end local v9    # "element$iv":Ljava/lang/Object;
    goto :goto_3

    .line 413
    :cond_5
    nop

    .line 260
    .end local v6    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v7    # "$i$f$forEach":I
    invoke-static {v3, v5}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$sendLPRTrack(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;)V

    .line 262
    .end local v5    # "lPRModel":Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;
    :goto_4
    nop

    .line 237
    .end local v2    # "it":Lcom/rokid/aicore/api/callback/result/LPRResult;
    .end local v4    # "$i$a$-let-TrackManager$initLpr$1$onLPREvent$1":I
    goto :goto_5

    .line 264
    :cond_6
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initLpr$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "#onLPREvent: recgLprResultArrayList is empty"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 266
    :cond_7
    :goto_5
    return-void
.end method
