.class public final Lcom/rokid/security/sdk/ability/asr/AsrManager;
.super Ljava/lang/Object;
.source "AsrManager.kt"

# interfaces
.implements Lcom/rokid/security/sdk/ability/message/ICommonMessage;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/asr/AsrManager$MyAsrListener;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nAsrManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 AsrManager.kt\ncom/rokid/security/sdk/ability/asr/AsrManager\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,486:1\n1855#2,2:487\n*S KotlinDebug\n*F\n+ 1 AsrManager.kt\ncom/rokid/security/sdk/ability/asr/AsrManager\n*L\n285#1:487,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\\\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0010\u0008\n\u0002\u0008\t\n\u0002\u0010\u0012\n\u0002\u0008\u0013\u0008\u00c6\u0002\u0018\u00002\u00020\u0001:\u0001:B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u0016\u001a\u0004\u0018\u00010\u00062\u0006\u0010\u0017\u001a\u00020\u0006J\u0006\u0010\u0018\u001a\u00020\u0019J*\u0010\u001a\u001a\u00020\u00192\u0006\u0010\u001b\u001a\u00020\u00062\u0018\u0010\u001c\u001a\u0014\u0012\u0004\u0012\u00020\u001e\u0012\u0004\u0012\u00020\u0006\u0012\u0004\u0012\u00020\u00190\u001dH\u0002J\u0006\u0010\u001f\u001a\u00020\u0019J*\u0010 \u001a\u00020\u00192\u0006\u0010!\u001a\u00020\u00062\u0018\u0010\u001c\u001a\u0014\u0012\u0004\u0012\u00020\u001e\u0012\u0004\u0012\u00020\u0006\u0012\u0004\u0012\u00020\u00190\u001dH\u0002J\u0010\u0010\"\u001a\u00020\u00192\u0006\u0010#\u001a\u00020\u0006H\u0002J\u000e\u0010$\u001a\u00020\u00192\u0006\u0010%\u001a\u00020\nJ\u0010\u0010&\u001a\u00020\u00192\u0006\u0010\'\u001a\u00020(H\u0002J\u0018\u0010)\u001a\u00020\u00192\u0006\u0010\'\u001a\u00020(2\u0006\u0010*\u001a\u00020\u001eH\u0016J\u0010\u0010+\u001a\u00020\u00192\u0006\u0010,\u001a\u00020\u0011H\u0002J\u0010\u0010-\u001a\u00020\u00192\u0006\u0010.\u001a\u00020\u001eH\u0002J\u0010\u0010/\u001a\u00020\u00192\u0006\u0010#\u001a\u00020\u0006H\u0002J\u0018\u00100\u001a\u00020\u00192\u0006\u00101\u001a\u00020\u00062\u0006\u0010*\u001a\u00020\u001eH\u0016J\u0008\u00102\u001a\u00020\u0019H\u0002J\u0018\u00103\u001a\u00020\u00192\u0006\u0010\'\u001a\u00020(2\u0006\u0010*\u001a\u00020\u001eH\u0016J\u0010\u00104\u001a\u00020\u00062\u0006\u00105\u001a\u00020\u0006H\u0002J\u0018\u00106\u001a\u00020\u00192\u0006\u0010#\u001a\u00020\u00062\u0006\u00107\u001a\u00020\u0011H\u0002J\u0008\u00108\u001a\u00020\u0019H\u0002J\u0008\u00109\u001a\u00020\u0019H\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082T\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0007\u001a\u0004\u0018\u00010\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\t\u001a\u0004\u0018\u00010\nX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\r\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000e\u001a\u00020\u000fX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0010\u001a\u00020\u0011X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0012\u001a\u00020\u0013X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0014\u001a\u00020\u0015X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006;"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/asr/AsrManager;",
        "Lcom/rokid/security/sdk/ability/message/ICommonMessage;",
        "()V",
        "MIRROR_ASR_QUESTION_TTL_MS",
        "",
        "TAG",
        "",
        "connectStateJob",
        "Lkotlinx/coroutines/Job;",
        "curAsrExtra",
        "Lcom/rokid/security/sdk/base/common/AsrExtra;",
        "currentMirrorAsrQuestionId",
        "currentMirrorAsrQuestionText",
        "currentMirrorAsrQuestionTime",
        "initialized",
        "Ljava/util/concurrent/atomic/AtomicBoolean;",
        "isCurStart",
        "",
        "mirrorSeq",
        "Ljava/util/concurrent/atomic/AtomicLong;",
        "myMyAsrListener",
        "Lcom/rokid/security/sdk/ability/asr/AsrManager$MyAsrListener;",
        "consumeMirrorAsrQuestionId",
        "question",
        "destroy",
        "",
        "handleIntent",
        "text",
        "callBack",
        "Lkotlin/Function2;",
        "",
        "initAsr",
        "normalRespobse",
        "asrText",
        "onAsrComplete",
        "asr",
        "onAsrMethod",
        "extra",
        "onAudioData",
        "buffer",
        "",
        "onAudioStream",
        "type",
        "onConnectState",
        "connect",
        "onError",
        "errCode",
        "onIntermediateVad",
        "onMessage",
        "msg",
        "onStart",
        "onVideoStream",
        "removeLastPunctuation",
        "input",
        "sendMirrorAsr",
        "isFinal",
        "startSpeech",
        "stopSpeech",
        "MyAsrListener",
        "sdk-common-ability_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrManager;

.field private static final MIRROR_ASR_QUESTION_TTL_MS:J = 0x2710L

.field private static final TAG:Ljava/lang/String; = "AsrManager::"

.field private static connectStateJob:Lkotlinx/coroutines/Job;

.field private static curAsrExtra:Lcom/rokid/security/sdk/base/common/AsrExtra;

.field private static currentMirrorAsrQuestionId:Ljava/lang/String;

.field private static currentMirrorAsrQuestionText:Ljava/lang/String;

.field private static currentMirrorAsrQuestionTime:J

.field private static final initialized:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static volatile isCurStart:Z

.field private static final mirrorSeq:Ljava/util/concurrent/atomic/AtomicLong;

.field private static myMyAsrListener:Lcom/rokid/security/sdk/ability/asr/AsrManager$MyAsrListener;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    new-instance v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/asr/AsrManager;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrManager;

    .line 42
    new-instance v0, Lcom/rokid/security/sdk/ability/asr/AsrManager$MyAsrListener;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/asr/AsrManager$MyAsrListener;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->myMyAsrListener:Lcom/rokid/security/sdk/ability/asr/AsrManager$MyAsrListener;

    .line 45
    const-string v0, ""

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->currentMirrorAsrQuestionId:Ljava/lang/String;

    .line 46
    sput-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->currentMirrorAsrQuestionText:Ljava/lang/String;

    .line 48
    new-instance v0, Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v1, 0x0

    invoke-direct {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicLong;-><init>(J)V

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->mirrorSeq:Ljava/util/concurrent/atomic/AtomicLong;

    .line 49
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->initialized:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$isCurStart$p()Z
    .locals 1

    .line 37
    sget-boolean v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->isCurStart:Z

    return v0
.end method

.method public static final synthetic access$onAsrComplete(Lcom/rokid/security/sdk/ability/asr/AsrManager;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/asr/AsrManager;
    .param p1, "asr"    # Ljava/lang/String;

    .line 37
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->onAsrComplete(Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$onConnectState(Lcom/rokid/security/sdk/ability/asr/AsrManager;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/asr/AsrManager;
    .param p1, "connect"    # Z

    .line 37
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->onConnectState(Z)V

    return-void
.end method

.method public static final synthetic access$onError(Lcom/rokid/security/sdk/ability/asr/AsrManager;I)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/asr/AsrManager;
    .param p1, "errCode"    # I

    .line 37
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->onError(I)V

    return-void
.end method

.method public static final synthetic access$onIntermediateVad(Lcom/rokid/security/sdk/ability/asr/AsrManager;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/asr/AsrManager;
    .param p1, "asr"    # Ljava/lang/String;

    .line 37
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->onIntermediateVad(Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$onStart(Lcom/rokid/security/sdk/ability/asr/AsrManager;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/asr/AsrManager;

    .line 37
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->onStart()V

    return-void
.end method

.method public static final synthetic access$setCurStart$p(Z)V
    .locals 0
    .param p0, "<set-?>"    # Z

    .line 37
    sput-boolean p0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->isCurStart:Z

    return-void
.end method

.method private final handleIntent(Ljava/lang/String;Lkotlin/jvm/functions/Function2;)V
    .locals 22
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "callBack"    # Lkotlin/jvm/functions/Function2;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function2<",
            "-",
            "Ljava/lang/Integer;",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 266
    move-object/from16 v0, p2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    .line 267
    .local v1, "currentTime":J
    const/4 v3, 0x0

    .line 268
    .local v3, "scene":I
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "s_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const v5, 0x927c0

    int-to-long v5, v5

    div-long v5, v1, v5

    invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 269
    .local v4, "sessionId":Ljava/lang/String;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "t_"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 270
    .local v5, "traceId":Ljava/lang/String;
    invoke-direct/range {p0 .. p1}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->removeLastPunctuation(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 271
    .local v6, "input":Ljava/lang/String;
    sget-object v7, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    invoke-virtual {v7, v6, v3, v4, v5}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->predict(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;

    move-result-object v7

    .line 272
    .local v7, "nluResult":Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;
    if-eqz v7, :cond_2c

    iget v8, v7, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->status:I

    const/4 v9, 0x1

    if-eq v8, v9, :cond_0

    move-wide/from16 v20, v1

    goto/16 :goto_13

    .line 277
    :cond_0
    iget-object v8, v7, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->intent:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$IntentResult;

    iget v8, v8, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$IntentResult;->intent:I

    .line 278
    .local v8, "intentValue":I
    nop

    .line 280
    nop

    .line 279
    sget-object v10, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_VOLUME_SET:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v10}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v10

    if-ne v8, v10, :cond_1

    move v10, v9

    goto :goto_0

    .line 280
    :cond_1
    sget-object v10, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_BRIGHTNESS_SET:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v10}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v10

    if-ne v8, v10, :cond_2

    move v10, v9

    goto :goto_0

    :cond_2
    const/4 v10, 0x0

    :goto_0
    if-eqz v10, :cond_3

    .line 281
    sget-object v10, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;

    invoke-virtual {v10, v6}, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;->parse(Ljava/lang/String;)Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;

    move-result-object v10

    goto :goto_1

    .line 282
    :cond_3
    const/4 v10, 0x0

    .line 278
    :goto_1
    nop

    .line 284
    .local v10, "settingValue":Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;
    new-instance v12, Lorg/json/JSONObject;

    invoke-direct {v12}, Lorg/json/JSONObject;-><init>()V

    move-object v13, v12

    .local v13, "$this$handleIntent_u24lambda_u242":Lorg/json/JSONObject;
    const/4 v14, 0x0

    .line 285
    .local v14, "$i$a$-apply-AsrManager$handleIntent$intentJson$1":I
    iget-object v15, v7, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->slot:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$SlotResult;

    if-eqz v15, :cond_5

    iget-object v15, v15, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$SlotResult;->slots:Ljava/util/List;

    if-eqz v15, :cond_5

    const-string/jumbo v9, "slots"

    invoke-static {v15, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v9, v15

    check-cast v9, Ljava/lang/Iterable;

    .local v9, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v15, 0x0

    .line 487
    .local v15, "$i$f$forEach":I
    invoke-interface {v9}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v17

    :goto_2
    invoke-interface/range {v17 .. v17}, Ljava/util/Iterator;->hasNext()Z

    move-result v18

    if-eqz v18, :cond_4

    invoke-interface/range {v17 .. v17}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v18

    .local v18, "element$iv":Ljava/lang/Object;
    move-object/from16 v11, v18

    check-cast v11, Landroid/util/Pair;

    .local v11, "slot":Landroid/util/Pair;
    const/16 v19, 0x0

    .line 286
    .local v19, "$i$a$-forEach-AsrManager$handleIntent$intentJson$1$1":I
    move-wide/from16 v20, v1

    .end local v1    # "currentTime":J
    .local v20, "currentTime":J
    iget-object v1, v11, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    iget-object v2, v11, Landroid/util/Pair;->second:Ljava/lang/Object;

    invoke-virtual {v13, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 287
    nop

    .line 487
    .end local v11    # "slot":Landroid/util/Pair;
    .end local v19    # "$i$a$-forEach-AsrManager$handleIntent$intentJson$1$1":I
    move-wide/from16 v1, v20

    .end local v18    # "element$iv":Ljava/lang/Object;
    goto :goto_2

    .line 488
    .end local v20    # "currentTime":J
    .restart local v1    # "currentTime":J
    :cond_4
    move-wide/from16 v20, v1

    .end local v1    # "currentTime":J
    .end local v9    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v15    # "$i$f$forEach":I
    .restart local v20    # "currentTime":J
    goto :goto_3

    .line 285
    .end local v20    # "currentTime":J
    .restart local v1    # "currentTime":J
    :cond_5
    move-wide/from16 v20, v1

    .line 288
    .end local v1    # "currentTime":J
    .restart local v20    # "currentTime":J
    :goto_3
    if-eqz v10, :cond_7

    move-object v1, v10

    .local v1, "it":Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;
    const/4 v2, 0x0

    .line 289
    .local v2, "$i$a$-let-AsrManager$handleIntent$intentJson$1$2":I
    sget-object v9, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_VOLUME_SET:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v9}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v9

    if-ne v8, v9, :cond_6

    .line 290
    const-string/jumbo v9, "volume"

    goto :goto_4

    .line 292
    :cond_6
    const-string v9, "brightness"

    .line 289
    :goto_4
    nop

    .line 294
    .local v9, "key":Ljava/lang/String;
    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->getValue()I

    move-result v11

    invoke-virtual {v13, v9, v11}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 295
    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->getUnit()Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    move-result-object v11

    invoke-virtual {v11}, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;->getWireValue()Ljava/lang/String;

    move-result-object v11

    const-string/jumbo v15, "valueUnit"

    invoke-virtual {v13, v15, v11}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 296
    nop

    .line 288
    .end local v1    # "it":Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;
    .end local v2    # "$i$a$-let-AsrManager$handleIntent$intentJson$1$2":I
    .end local v9    # "key":Ljava/lang/String;
    nop

    .line 297
    :cond_7
    nop

    .line 284
    .end local v13    # "$this$handleIntent_u24lambda_u242":Lorg/json/JSONObject;
    .end local v14    # "$i$a$-apply-AsrManager$handleIntent$intentJson$1":I
    nop

    .line 297
    invoke-virtual {v12}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "JSONObject().apply {\n   \u2026   }\n        }.toString()"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 284
    nop

    .line 299
    .local v1, "intentJson":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "handleIntent value="

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v9, " status="

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v9, v7, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->status:I

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    const-string v9, "AsrManager::"

    invoke-static {v9, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 300
    nop

    .line 301
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_OPEN_APP:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    const-string v11, ""

    if-ne v8, v2, :cond_8

    .line 302
    const-string v2, "INTENT_OPEN_APP"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v9, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 303
    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v2, v11}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_12

    .line 305
    :cond_8
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_TAKE_PHOTO:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_9

    .line 306
    const-string v2, "INTENT_TAKE_PHOTO"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v9, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 307
    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v2, v11}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_12

    .line 309
    :cond_9
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_VISION:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_a

    .line 310
    const-string v2, "INTENT_VISION"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v9, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 311
    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v2, v11}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_12

    .line 326
    :cond_a
    nop

    .line 325
    nop

    .line 324
    nop

    .line 323
    nop

    .line 322
    nop

    .line 321
    nop

    .line 320
    nop

    .line 319
    nop

    .line 318
    nop

    .line 317
    nop

    .line 316
    nop

    .line 315
    nop

    .line 314
    nop

    .line 313
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_VOLUME_UP:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_b

    const/4 v2, 0x1

    goto :goto_5

    .line 314
    :cond_b
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_VOLUME_DOWN:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_c

    const/4 v2, 0x1

    goto :goto_5

    :cond_c
    const/4 v2, 0x0

    :goto_5
    if-eqz v2, :cond_d

    const/4 v2, 0x1

    goto :goto_6

    .line 315
    :cond_d
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_VOLUME_FULL:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_e

    const/4 v2, 0x1

    goto :goto_6

    :cond_e
    const/4 v2, 0x0

    :goto_6
    if-eqz v2, :cond_f

    const/4 v2, 0x1

    goto :goto_7

    .line 316
    :cond_f
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_VOLUME_SILENCE:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_10

    const/4 v2, 0x1

    goto :goto_7

    :cond_10
    const/4 v2, 0x0

    :goto_7
    if-eqz v2, :cond_11

    const/4 v2, 0x1

    goto :goto_8

    .line 317
    :cond_11
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_VOLUME_UNMUTE:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_12

    const/4 v2, 0x1

    goto :goto_8

    :cond_12
    const/4 v2, 0x0

    :goto_8
    if-eqz v2, :cond_13

    const/4 v2, 0x1

    goto :goto_9

    .line 318
    :cond_13
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_VOLUME_QUERY:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_14

    const/4 v2, 0x1

    goto :goto_9

    :cond_14
    const/4 v2, 0x0

    :goto_9
    if-eqz v2, :cond_15

    const/4 v2, 0x1

    goto :goto_a

    .line 319
    :cond_15
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_BRIGHTNESS_UP:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_16

    const/4 v2, 0x1

    goto :goto_a

    :cond_16
    const/4 v2, 0x0

    :goto_a
    if-eqz v2, :cond_17

    const/4 v2, 0x1

    goto :goto_b

    .line 320
    :cond_17
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_BRIGHTNESS_DOWN:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_18

    const/4 v2, 0x1

    goto :goto_b

    :cond_18
    const/4 v2, 0x0

    :goto_b
    if-eqz v2, :cond_19

    const/4 v2, 0x1

    goto :goto_c

    .line 321
    :cond_19
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_BRIGHTNESS_FULL:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_1a

    const/4 v2, 0x1

    goto :goto_c

    :cond_1a
    const/4 v2, 0x0

    :goto_c
    if-eqz v2, :cond_1b

    const/4 v2, 0x1

    goto :goto_d

    .line 322
    :cond_1b
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_BRIGHTNESS_MIN:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_1c

    const/4 v2, 0x1

    goto :goto_d

    :cond_1c
    const/4 v2, 0x0

    :goto_d
    if-eqz v2, :cond_1d

    const/4 v2, 0x1

    goto :goto_e

    .line 323
    :cond_1d
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_BRIGHTNESS_QUERY:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_1e

    const/4 v2, 0x1

    goto :goto_e

    :cond_1e
    const/4 v2, 0x0

    :goto_e
    if-eqz v2, :cond_1f

    const/4 v2, 0x1

    goto :goto_f

    .line 324
    :cond_1f
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_QUERY_BATTERY:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_20

    const/4 v2, 0x1

    goto :goto_f

    :cond_20
    const/4 v2, 0x0

    :goto_f
    if-eqz v2, :cond_21

    const/4 v2, 0x1

    goto :goto_10

    .line 325
    :cond_21
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_QUERY_TIME:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_22

    const/4 v2, 0x1

    goto :goto_10

    :cond_22
    const/4 v2, 0x0

    :goto_10
    if-eqz v2, :cond_23

    const/16 v16, 0x1

    goto :goto_11

    .line 326
    :cond_23
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_QUERY_DATE:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_24

    const/16 v16, 0x1

    goto :goto_11

    :cond_24
    const/16 v16, 0x0

    :goto_11
    if-eqz v16, :cond_25

    .line 327
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "resolved local system intent="

    invoke-virtual {v2, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v9, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 328
    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v2, v1}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_12

    .line 330
    :cond_25
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_VOLUME_SET:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_27

    .line 331
    if-eqz v10, :cond_26

    .line 332
    const-string v2, "INTENT_VOLUME_SET"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v9, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 333
    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v2, v1}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_12

    .line 335
    :cond_26
    invoke-direct/range {p0 .. p2}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->normalRespobse(Ljava/lang/String;Lkotlin/jvm/functions/Function2;)V

    goto :goto_12

    .line 338
    :cond_27
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_BRIGHTNESS_SET:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_29

    .line 339
    if-eqz v10, :cond_28

    .line 340
    const-string v2, "INTENT_BRIGHTNESS_SET"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v9, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 341
    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v2, v1}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_12

    .line 343
    :cond_28
    invoke-direct/range {p0 .. p2}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->normalRespobse(Ljava/lang/String;Lkotlin/jvm/functions/Function2;)V

    goto :goto_12

    .line 346
    :cond_29
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_SEARCH:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_2a

    .line 347
    const-string v2, "INTENT_SEARCH"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v9, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 348
    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v2, v11}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_12

    .line 350
    :cond_2a
    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_EXIT_AI_CHAT:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    if-ne v8, v2, :cond_2b

    .line 351
    const-string v2, "INTENT_EXIT_AI_CHAT"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v9, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 353
    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v2, v11}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_12

    .line 356
    :cond_2b
    invoke-direct/range {p0 .. p2}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->normalRespobse(Ljava/lang/String;Lkotlin/jvm/functions/Function2;)V

    .line 359
    :goto_12
    return-void

    .line 272
    .end local v8    # "intentValue":I
    .end local v10    # "settingValue":Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;
    .end local v20    # "currentTime":J
    .local v1, "currentTime":J
    :cond_2c
    move-wide/from16 v20, v1

    .line 273
    .end local v1    # "currentTime":J
    .restart local v20    # "currentTime":J
    :goto_13
    invoke-direct/range {p0 .. p2}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->normalRespobse(Ljava/lang/String;Lkotlin/jvm/functions/Function2;)V

    .line 274
    return-void
.end method

.method private final normalRespobse(Ljava/lang/String;Lkotlin/jvm/functions/Function2;)V
    .locals 8
    .param p1, "asrText"    # Ljava/lang/String;
    .param p2, "callBack"    # Lkotlin/jvm/functions/Function2;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function2<",
            "-",
            "Ljava/lang/Integer;",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 237
    const-string v0, "normalRespobse"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AsrManager::"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 238
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector;

    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector;->isDirectPhotoIntent(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 239
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "fallback resolved locally intent=take_photo chars="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 240
    sget-object v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_TAKE_PHOTO:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v0}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    const-string v1, ""

    invoke-interface {p2, v0, v1}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 241
    return-void

    .line 244
    :cond_0
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    .line 245
    .local v0, "done":Ljava/util/concurrent/atomic/AtomicBoolean;
    new-instance v1, Lcom/rokid/security/sdk/ability/param/AsrRequestParam;

    invoke-direct {v1, p1}, Lcom/rokid/security/sdk/ability/param/AsrRequestParam;-><init>(Ljava/lang/String;)V

    .line 246
    .local v1, "asrRequestParam":Lcom/rokid/security/sdk/ability/param/AsrRequestParam;
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v2

    new-instance v3, Lcom/rokid/security/sdk/ability/asr/AsrManager$normalRespobse$1;

    const/4 v4, 0x0

    invoke-direct {v3, v0, p2, v4}, Lcom/rokid/security/sdk/ability/asr/AsrManager$normalRespobse$1;-><init>(Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)V

    move-object v5, v3

    check-cast v5, Lkotlin/jvm/functions/Function2;

    const/4 v6, 0x3

    const/4 v7, 0x0

    const/4 v3, 0x0

    invoke-static/range {v2 .. v7}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 253
    sget-object v2, Lcom/rokid/security/sdk/ability/param/ASRRequest;->INSTANCE:Lcom/rokid/security/sdk/ability/param/ASRRequest;

    new-instance v3, Lcom/rokid/security/sdk/ability/asr/AsrManager$normalRespobse$2;

    invoke-direct {v3, v0, p2}, Lcom/rokid/security/sdk/ability/asr/AsrManager$normalRespobse$2;-><init>(Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/jvm/functions/Function2;)V

    check-cast v3, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v2, v1, v3}, Lcom/rokid/security/sdk/ability/param/ASRRequest;->asrInt(Lcom/rokid/security/sdk/ability/param/AsrRequestParam;Lkotlin/jvm/functions/Function1;)V

    .line 263
    return-void
.end method

.method private final onAsrComplete(Ljava/lang/String;)V
    .locals 2
    .param p1, "asr"    # Ljava/lang/String;

    .line 213
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onAsrComplete chars="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AsrManager::"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 214
    new-instance v0, Lcom/rokid/security/sdk/base/common/AsrExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AsrExtra;-><init>()V

    .line 215
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/AsrExtra;
    const-string v1, "onAsrComplete"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/AsrExtra;->setMethodName(Ljava/lang/String;)V

    .line 217
    new-instance v1, Lcom/rokid/security/sdk/ability/asr/AsrManager$onAsrComplete$1;

    invoke-direct {v1, v0, p1}, Lcom/rokid/security/sdk/ability/asr/AsrManager$onAsrComplete$1;-><init>(Lcom/rokid/security/sdk/base/common/AsrExtra;Ljava/lang/String;)V

    check-cast v1, Lkotlin/jvm/functions/Function2;

    invoke-direct {p0, p1, v1}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->handleIntent(Ljava/lang/String;Lkotlin/jvm/functions/Function2;)V

    .line 225
    return-void
.end method

.method private final onAudioData([B)V
    .locals 2
    .param p1, "buffer"    # [B

    .line 138
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->curAsrExtra:Lcom/rokid/security/sdk/base/common/AsrExtra;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/AsrExtra;->getMethodName()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    const-string/jumbo v1, "startSpeech"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 139
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->doSpeechVoice([B)V

    .line 141
    :cond_1
    return-void
.end method

.method private final onConnectState(Z)V
    .locals 10
    .param p1, "connect"    # Z

    .line 416
    const-string v0, "onConnectState-->"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AsrManager::"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 417
    new-instance v0, Lcom/rokid/security/sdk/base/common/AsrExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AsrExtra;-><init>()V

    .line 418
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/AsrExtra;
    const-string v1, "connectState"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/AsrExtra;->setMethodName(Ljava/lang/String;)V

    .line 419
    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/base/common/AsrExtra;->setConnectState(Z)V

    .line 420
    sget-object v1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 421
    .local v1, "extraStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    const-string v3, "extraStr"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "ASR_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalData$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 422
    return-void
.end method

.method private final onError(I)V
    .locals 10
    .param p1, "errCode"    # I

    .line 362
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onError-->"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AsrManager::"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 363
    new-instance v0, Lcom/rokid/security/sdk/base/common/AsrExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AsrExtra;-><init>()V

    .line 364
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/AsrExtra;
    const-string v1, "onError"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/AsrExtra;->setMethodName(Ljava/lang/String;)V

    .line 365
    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/base/common/AsrExtra;->setErrCode(I)V

    .line 366
    sget-object v1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 367
    .local v1, "extraStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    const-string v3, "extraStr"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "ASR_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalData$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 368
    return-void
.end method

.method private final onIntermediateVad(Ljava/lang/String;)V
    .locals 10
    .param p1, "asr"    # Ljava/lang/String;

    .line 201
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onIntermediateVad chars="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AsrManager::"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 202
    new-instance v0, Lcom/rokid/security/sdk/base/common/AsrExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AsrExtra;-><init>()V

    .line 203
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/AsrExtra;
    const-string v1, "onIntermediateVad"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/AsrExtra;->setMethodName(Ljava/lang/String;)V

    .line 204
    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/base/common/AsrExtra;->setAsrContent(Ljava/lang/String;)V

    .line 205
    sget-object v1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 206
    .local v1, "extraStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    const-string v3, "extraStr"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "ASR_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalData$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 207
    const/4 v2, 0x0

    invoke-direct {p0, p1, v2}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->sendMirrorAsr(Ljava/lang/String;Z)V

    .line 208
    return-void
.end method

.method private final onStart()V
    .locals 10

    .line 372
    const-string v0, "onStart-->"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AsrManager::"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 373
    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "randomUUID().toString()"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->currentMirrorAsrQuestionId:Ljava/lang/String;

    .line 374
    new-instance v0, Lcom/rokid/security/sdk/base/common/AsrExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AsrExtra;-><init>()V

    .line 375
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/AsrExtra;
    const-string v1, "onStart"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/AsrExtra;->setMethodName(Ljava/lang/String;)V

    .line 376
    sget-object v1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 377
    .local v1, "extraStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    const-string v3, "extraStr"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "ASR_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalData$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 378
    return-void
.end method

.method private final removeLastPunctuation(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "input"    # Ljava/lang/String;

    .line 229
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/4 v1, 0x1

    if-lez v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-eqz v0, :cond_1

    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->last(Ljava/lang/CharSequence;)C

    move-result v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    new-instance v2, Lkotlin/text/Regex;

    const-string v3, "\\p{Punct}"

    invoke-direct {v2, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Lkotlin/text/Regex;->matches(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 230
    invoke-static {p1, v1}, Lkotlin/text/StringsKt;->dropLast(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 232
    :cond_1
    move-object v0, p1

    .line 229
    :goto_1
    return-object v0
.end method

.method private final sendMirrorAsr(Ljava/lang/String;Z)V
    .locals 10
    .param p1, "asr"    # Ljava/lang/String;
    .param p2, "isFinal"    # Z

    .line 381
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 382
    :cond_0
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->currentMirrorAsrQuestionId:Ljava/lang/String;

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 383
    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "randomUUID().toString()"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->currentMirrorAsrQuestionId:Ljava/lang/String;

    .line 385
    :cond_1
    sput-object p1, Lcom/rokid/security/sdk/ability/asr/AsrManager;->currentMirrorAsrQuestionText:Ljava/lang/String;

    .line 386
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sput-wide v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->currentMirrorAsrQuestionTime:J

    .line 387
    new-instance v0, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendMirrorAsr_u24lambda_u243":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const/4 v2, 0x0

    .line 388
    .local v2, "$i$a$-apply-AsrManager$sendMirrorAsr$extra$1":I
    if-eqz p2, :cond_2

    const-string v3, "mirrorAsrFinal"

    goto :goto_0

    :cond_2
    const-string v3, "mirrorAsrPartial"

    :goto_0
    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMethodName(Ljava/lang/String;)V

    .line 389
    sget-object v3, Lcom/rokid/security/sdk/ability/asr/AsrManager;->currentMirrorAsrQuestionId:Ljava/lang/String;

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setQuestionId(Ljava/lang/String;)V

    .line 390
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setQuestion(Ljava/lang/String;)V

    .line 391
    const-string v3, "glass_wifi_direct"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setSource(Ljava/lang/String;)V

    .line 392
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/rokid/security/sdk/ability/asr/AsrManager;->currentMirrorAsrQuestionId:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ":asr:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/rokid/security/sdk/ability/asr/AsrManager;->mirrorSeq:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v4}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMirrorSeq(Ljava/lang/String;)V

    .line 393
    nop

    .line 387
    .end local v1    # "$this$sendMirrorAsr_u24lambda_u243":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v2    # "$i$a$-apply-AsrManager$sendMirrorAsr$extra$1":I
    nop

    .line 394
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    sget-object v1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    .line 395
    nop

    .line 396
    sget-object v2, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const-string v2, "SenderHandler.mGson.toJson(extra)"

    invoke-static {v3, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 397
    nop

    .line 394
    const/16 v8, 0x38

    const/4 v9, 0x0

    const-string v2, "AI_CHAT_MIRROR_ACTION"

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-static/range {v1 .. v9}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalDataByNetworkMode$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 399
    return-void
.end method

.method private final startSpeech()V
    .locals 2

    .line 172
    const-string/jumbo v0, "startSpeech-->"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AsrManager::"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 173
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->startSpeech()V

    .line 174
    return-void
.end method

.method private final stopSpeech()V
    .locals 2

    .line 179
    const-string/jumbo v0, "stopSpeech-->"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AsrManager::"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 180
    const/4 v0, 0x0

    sput-boolean v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->isCurStart:Z

    .line 181
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->stopSpeech()V

    .line 182
    return-void
.end method


# virtual methods
.method public final consumeMirrorAsrQuestionId(Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .param p1, "question"    # Ljava/lang/String;

    const-string v0, "question"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 402
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->currentMirrorAsrQuestionId:Ljava/lang/String;

    .line 403
    .local v0, "questionId":Ljava/lang/String;
    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    return-object v2

    .line 404
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    sget-wide v5, Lcom/rokid/security/sdk/ability/asr/AsrManager;->currentMirrorAsrQuestionTime:J

    sub-long/2addr v3, v5

    const-wide/16 v5, 0x2710

    cmp-long v1, v3, v5

    if-lez v1, :cond_1

    return-object v2

    .line 405
    :cond_1
    const-string v1, ""

    sput-object v1, Lcom/rokid/security/sdk/ability/asr/AsrManager;->currentMirrorAsrQuestionId:Ljava/lang/String;

    .line 406
    sput-object v1, Lcom/rokid/security/sdk/ability/asr/AsrManager;->currentMirrorAsrQuestionText:Ljava/lang/String;

    .line 407
    const-wide/16 v1, 0x0

    sput-wide v1, Lcom/rokid/security/sdk/ability/asr/AsrManager;->currentMirrorAsrQuestionTime:J

    .line 408
    return-object v0
.end method

.method public final declared-synchronized destroy()V
    .locals 3

    monitor-enter p0

    .line 189
    :try_start_0
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->initialized:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->getAndSet(Z)Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    monitor-exit p0

    return-void

    .line 190
    :cond_0
    :try_start_1
    const-string v0, "AsrManager::"

    const-string v1, "destroy-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 191
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->connectStateJob:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 192
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrManager;
    :cond_1
    sput-object v1, Lcom/rokid/security/sdk/ability/asr/AsrManager;->connectStateJob:Lkotlinx/coroutines/Job;

    .line 194
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->destroy()V

    .line 195
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->release()V

    .line 196
    sget-object v0, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageReceiver;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->getMessageAction()Lcom/rokid/security/sdk/ability/message/IMessageAction;

    move-result-object v0

    move-object v1, p0

    check-cast v1, Lcom/rokid/security/sdk/ability/message/ICommonMessage;

    invoke-interface {v0, v1}, Lcom/rokid/security/sdk/ability/message/IMessageAction;->unInjectIMessage(Lcom/rokid/security/sdk/ability/message/ICommonMessage;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 197
    monitor-exit p0

    return-void

    .line 188
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized initAsr()V
    .locals 13

    monitor-enter p0

    .line 54
    :try_start_0
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->initialized:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-nez v0, :cond_0

    .line 55
    const-string v0, "AsrManager::"

    const-string v1, "initAsr ignored: already initialized"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 56
    monitor-exit p0

    return-void

    .line 59
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrManager;
    :cond_0
    nop

    .line 60
    const/4 v0, 0x0

    :try_start_1
    sget-object v3, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageReceiver;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->getMessageAction()Lcom/rokid/security/sdk/ability/message/IMessageAction;

    move-result-object v3

    move-object v4, p0

    check-cast v4, Lcom/rokid/security/sdk/ability/message/ICommonMessage;

    invoke-interface {v3, v4}, Lcom/rokid/security/sdk/ability/message/IMessageAction;->injectIMessage(Lcom/rokid/security/sdk/ability/message/ICommonMessage;)V

    .line 61
    const-string v3, "AsrManager::"

    const-string v4, "initAsr->"

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 63
    new-instance v3, Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    invoke-direct {v3}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;-><init>()V

    .line 64
    .local v3, "mConfig":Lcom/rokid/security/sdk/ability/bean/BaseConfig;
    sget-object v4, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getWS_ASR()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->setServerUrl(Ljava/lang/String;)V

    .line 65
    sget-object v4, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    sget-object v5, Lcom/rokid/security/sdk/ability/asr/AsrManager;->myMyAsrListener:Lcom/rokid/security/sdk/ability/asr/AsrManager$MyAsrListener;

    check-cast v5, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;

    invoke-virtual {v4, v3, v5}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->init(Lcom/rokid/security/sdk/ability/bean/BaseConfig;Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;)V

    .line 66
    const-string v4, "deviceId"

    .line 67
    .local v4, "deviceId":Ljava/lang/String;
    sget-object v5, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    invoke-static {}, Lcom/rokid/security/sdk/ability/util/ContextUtil;->getApplicationContext()Landroid/app/Application;

    move-result-object v6

    check-cast v6, Landroid/content/Context;

    invoke-virtual {v5, v6, v4}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->create(Landroid/content/Context;Ljava/lang/String;)V

    .line 74
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v7

    new-instance v5, Lcom/rokid/security/sdk/ability/asr/AsrManager$initAsr$1;

    invoke-direct {v5, v0}, Lcom/rokid/security/sdk/ability/asr/AsrManager$initAsr$1;-><init>(Lkotlin/coroutines/Continuation;)V

    move-object v10, v5

    check-cast v10, Lkotlin/jvm/functions/Function2;

    const/4 v11, 0x3

    const/4 v12, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    invoke-static/range {v7 .. v12}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v5

    sput-object v5, Lcom/rokid/security/sdk/ability/asr/AsrManager;->connectStateJob:Lkotlinx/coroutines/Job;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 91
    .end local v3    # "mConfig":Lcom/rokid/security/sdk/ability/bean/BaseConfig;
    .end local v4    # "deviceId":Ljava/lang/String;
    monitor-exit p0

    return-void

    .line 80
    :catchall_0
    move-exception v3

    .line 81
    .local v3, "e":Ljava/lang/Throwable;
    :try_start_2
    sget-object v4, Lcom/rokid/security/sdk/ability/asr/AsrManager;->initialized:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v4, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 82
    sget-object v2, Lcom/rokid/security/sdk/ability/asr/AsrManager;->connectStateJob:Lkotlinx/coroutines/Job;

    if-eqz v2, :cond_1

    invoke-static {v2, v0, v1, v0}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 83
    :cond_1
    sput-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->connectStateJob:Lkotlinx/coroutines/Job;

    .line 84
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->destroy()V

    .line 85
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->release()V

    .line 86
    sget-object v0, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageReceiver;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->getMessageAction()Lcom/rokid/security/sdk/ability/message/IMessageAction;

    move-result-object v0

    move-object v1, p0

    check-cast v1, Lcom/rokid/security/sdk/ability/message/ICommonMessage;

    invoke-interface {v0, v1}, Lcom/rokid/security/sdk/ability/message/IMessageAction;->unInjectIMessage(Lcom/rokid/security/sdk/ability/message/ICommonMessage;)V

    .line 87
    throw v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 53
    .end local v3    # "e":Ljava/lang/Throwable;
    :catchall_1
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final onAsrMethod(Lcom/rokid/security/sdk/base/common/AsrExtra;)V
    .locals 2
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/AsrExtra;

    const-string v0, "extra"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 148
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AsrExtra;->getMethodName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v1

    sparse-switch v1, :sswitch_data_0

    :goto_0
    goto :goto_1

    :sswitch_0
    const-string v1, "doSpeechVoice"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    goto :goto_0

    :sswitch_1
    const-string/jumbo v1, "stopSpeech"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 159
    :cond_0
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->stopSpeech()V

    goto :goto_1

    .line 148
    :sswitch_2
    const-string/jumbo v1, "startSpeech"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    .line 151
    :cond_1
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->startSpeech()V

    .line 164
    :goto_1
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        -0x6f79981c -> :sswitch_2
        -0x50a78c7c -> :sswitch_1
        0x4dc40be5 -> :sswitch_0
    .end sparse-switch
.end method

.method public onAudioStream([BI)V
    .locals 1
    .param p1, "buffer"    # [B
    .param p2, "type"    # I

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 477
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->onAudioData([B)V

    .line 478
    return-void
.end method

.method public onMessage(Ljava/lang/String;I)V
    .locals 5
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "type"    # I

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 465
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "ASR_ACTION"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x2

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {v0, v1, v4, v2, v3}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 466
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onMessage chars="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AsrManager::"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 467
    sget-object v0, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    const-class v1, Lcom/rokid/security/sdk/base/common/RkBaseData;

    invoke-virtual {v0, p1, v1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData;

    .line 468
    .local v0, "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData;->getExtra()Ljava/lang/String;

    move-result-object v1

    .line 469
    .local v1, "extra":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    const-class v3, Lcom/rokid/security/sdk/base/common/AsrExtra;

    invoke-virtual {v2, v1, v3}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/rokid/security/sdk/base/common/AsrExtra;

    .line 470
    .local v2, "mAsrExtra":Lcom/rokid/security/sdk/base/common/AsrExtra;
    sput-object v2, Lcom/rokid/security/sdk/ability/asr/AsrManager;->curAsrExtra:Lcom/rokid/security/sdk/base/common/AsrExtra;

    .line 471
    const-string v3, "mAsrExtra"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0, v2}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->onAsrMethod(Lcom/rokid/security/sdk/base/common/AsrExtra;)V

    .line 473
    .end local v0    # "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    .end local v1    # "extra":Ljava/lang/String;
    .end local v2    # "mAsrExtra":Lcom/rokid/security/sdk/base/common/AsrExtra;
    :cond_0
    return-void
.end method

.method public onVideoStream([BI)V
    .locals 1
    .param p1, "buffer"    # [B
    .param p2, "type"    # I

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 482
    return-void
.end method
