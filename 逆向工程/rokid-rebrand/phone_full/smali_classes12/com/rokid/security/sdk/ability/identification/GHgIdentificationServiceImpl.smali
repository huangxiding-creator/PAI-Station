.class public final Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;
.super Ljava/lang/Object;
.source "GHgIdentificationServiceImpl.kt"

# interfaces
.implements Lcom/rokid/security/sdk/ability/message/ICommonMessage;


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nGHgIdentificationServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 GHgIdentificationServiceImpl.kt\ncom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 3 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,421:1\n1#2:422\n1855#3,2:423\n*S KotlinDebug\n*F\n+ 1 GHgIdentificationServiceImpl.kt\ncom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl\n*L\n262#1:423,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000^\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0010\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0008\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0018\u0010\u0018\u001a\u00020\u00192\u0006\u0010\u001a\u001a\u00020\u00062\u0006\u0010\u001b\u001a\u00020\u0006H\u0002J\u0006\u0010\u001c\u001a\u00020\u001dJ\u0006\u0010\u001e\u001a\u00020\u001dJ0\u0010\u001f\u001a\u00020\u001d2\u0006\u0010 \u001a\u00020\u00062\u0006\u0010!\u001a\u00020\u00062\u0006\u0010\"\u001a\u00020\u00062\u0006\u0010#\u001a\u00020\u00062\u0006\u0010$\u001a\u00020\u0006H\u0002J\u001a\u0010%\u001a\u00020\u00062\u0008\u0010\u001a\u001a\u0004\u0018\u00010\u00062\u0006\u0010&\u001a\u00020\u0006H\u0002J\u0018\u0010\'\u001a\u00020\u001d2\u0006\u0010(\u001a\u00020\u00062\u0006\u0010)\u001a\u00020\tH\u0016J\u0010\u0010*\u001a\u00020\u00062\u0006\u0010(\u001a\u00020\u0006H\u0002J6\u0010+\u001a\u00020\u001d2\u0006\u0010\u001a\u001a\u00020\u00062\n\u0008\u0002\u0010,\u001a\u0004\u0018\u00010\u00062\u0008\u0010-\u001a\u0004\u0018\u00010.2\u0006\u0010/\u001a\u00020\u00192\u0006\u00100\u001a\u00020\u0006H\u0002J\u0014\u00101\u001a\u00020\u001d2\n\u0008\u0002\u0010\u001a\u001a\u0004\u0018\u00010\u0006H\u0002J\u0010\u00102\u001a\u00020\u001d2\u0006\u00103\u001a\u000204H\u0002J\u0010\u00105\u001a\u00020\u001d2\u0006\u00103\u001a\u000204H\u0002J\u0018\u00106\u001a\u00020\u001d2\u0006\u0010\u001a\u001a\u00020\u00062\u0006\u00107\u001a\u000204H\u0002J\u0010\u00108\u001a\u00020\u001d2\u0006\u0010\u001a\u001a\u00020\u0006H\u0002J*\u00109\u001a\u00020\u001d2\u0006\u0010\u001a\u001a\u00020\u00062\u0006\u0010\"\u001a\u00020\u00062\u0008\u0010,\u001a\u0004\u0018\u00010\u00062\u0006\u00107\u001a\u000204H\u0002J\u0010\u0010:\u001a\u00020\u001d2\u0006\u00103\u001a\u000204H\u0002J\u000e\u0010;\u001a\u00020\u001d2\u0006\u00103\u001a\u000204R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0006X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\tX\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u0006X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\u000cX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\r\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000e\u001a\u00020\u000fX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001c\u0010\u0010\u001a\u0004\u0018\u00010\u0011X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0012\u0010\u0013\"\u0004\u0008\u0014\u0010\u0015R\u000e\u0010\u0016\u001a\u00020\u0017X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006<"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;",
        "Lcom/rokid/security/sdk/ability/message/ICommonMessage;",
        "()V",
        "AUTH_READY_WAIT_MS",
        "",
        "MIRROR_IMAGE_STREAM_PREFIX",
        "",
        "MIRROR_SOURCE_GLASS_WIFI_DIRECT",
        "PHONE_RELAY_NETWORK_MODE",
        "",
        "TAG",
        "curAnswerContent",
        "Ljava/lang/StringBuffer;",
        "currentQuestionId",
        "mGson",
        "Lcom/google/gson/Gson;",
        "mOkHttpSSEClient",
        "Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;",
        "getMOkHttpSSEClient",
        "()Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;",
        "setMOkHttpSSEClient",
        "(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)V",
        "mirrorSeq",
        "Ljava/util/concurrent/atomic/AtomicLong;",
        "handleAiMessage",
        "",
        "questionId",
        "message",
        "identificationEnd",
        "",
        "initIdentification",
        "logIdentificationRequest",
        "url",
        "appId",
        "question",
        "imageBase64",
        "payload",
        "nextMirrorSeq",
        "event",
        "onMessage",
        "msg",
        "type",
        "sanitizeLargePayloadLog",
        "sendChatContent",
        "imageUrl",
        "content",
        "Lcom/rokid/security/sdk/base/common/aichat/AiContent;",
        "isFinish",
        "inputType",
        "sendError",
        "sendMirrorError",
        "extra",
        "Lcom/rokid/security/sdk/base/common/IdentificationExtra;",
        "sendMirrorExtra",
        "sendMirrorImage",
        "requestExtra",
        "sendMirrorModify",
        "sendMirrorQuestion",
        "sendMirrorResponse",
        "toIdentification",
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
.field private static final AUTH_READY_WAIT_MS:J = 0x3a98L

.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;

.field private static final MIRROR_IMAGE_STREAM_PREFIX:Ljava/lang/String; = "HG_IDENTIFICATION_MIRROR_IMAGE:"

.field private static final MIRROR_SOURCE_GLASS_WIFI_DIRECT:Ljava/lang/String; = "glass_wifi_direct"

.field private static final PHONE_RELAY_NETWORK_MODE:I

.field private static final TAG:Ljava/lang/String;

.field private static curAnswerContent:Ljava/lang/StringBuffer;

.field private static currentQuestionId:Ljava/lang/String;

.field private static mGson:Lcom/google/gson/Gson;

.field private static mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

.field private static final mirrorSeq:Ljava/util/concurrent/atomic/AtomicLong;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    new-instance v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;

    .line 48
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->curAnswerContent:Ljava/lang/StringBuffer;

    .line 50
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->mGson:Lcom/google/gson/Gson;

    .line 54
    new-instance v0, Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v1, 0x0

    invoke-direct {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicLong;-><init>(J)V

    sput-object v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->mirrorSeq:Ljava/util/concurrent/atomic/AtomicLong;

    .line 55
    const-string v0, ""

    sput-object v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->currentQuestionId:Ljava/lang/String;

    .line 58
    const-string v0, "GHgIdentificationServiceImpl::"

    sput-object v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 46
    sget-object v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$handleAiMessage(Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;
    .param p1, "questionId"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;

    .line 46
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->handleAiMessage(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static final synthetic access$logIdentificationRequest(Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "appId"    # Ljava/lang/String;
    .param p3, "question"    # Ljava/lang/String;
    .param p4, "imageBase64"    # Ljava/lang/String;
    .param p5, "payload"    # Ljava/lang/String;

    .line 46
    invoke-direct/range {p0 .. p5}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->logIdentificationRequest(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$sendChatContent(Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;
    .param p1, "questionId"    # Ljava/lang/String;
    .param p2, "imageUrl"    # Ljava/lang/String;
    .param p3, "content"    # Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .param p4, "isFinish"    # Z
    .param p5, "inputType"    # Ljava/lang/String;

    .line 46
    invoke-direct/range {p0 .. p5}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sendChatContent(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$sendError(Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;
    .param p1, "questionId"    # Ljava/lang/String;

    .line 46
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sendError(Ljava/lang/String;)V

    return-void
.end method

.method private final handleAiMessage(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 18
    .param p1, "questionId"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;

    .line 253
    move-object/from16 v0, p2

    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-nez v1, :cond_0

    move v1, v2

    goto :goto_0

    :cond_0
    move v1, v3

    :goto_0
    if-eqz v1, :cond_1

    .line 254
    return v3

    .line 256
    :cond_1
    new-instance v1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$handleAiMessage$type$1;

    invoke-direct {v1}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$handleAiMessage$type$1;-><init>()V

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$handleAiMessage$type$1;->getType()Ljava/lang/reflect/Type;

    move-result-object v1

    .line 257
    .local v1, "type":Ljava/lang/reflect/Type;
    sget-object v4, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->mGson:Lcom/google/gson/Gson;

    invoke-virtual {v4, v0, v1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/reflect/Type;)Ljava/lang/Object;

    move-result-object v4

    const-string v5, "mGson.fromJson(message, type)"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v4, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;

    .line 258
    .local v4, "aiResponse":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    sget-object v5, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "onChatAi-->"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getCode()Ljava/lang/Integer;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const/16 v7, 0x20

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v7, :cond_2

    invoke-virtual {v7}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getMessage()Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

    move-result-object v7

    if-eqz v7, :cond_2

    invoke-virtual {v7}, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->getContents()Ljava/util/List;

    move-result-object v7

    if-eqz v7, :cond_2

    invoke-interface {v7}, Ljava/util/List;->size()I

    move-result v7

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    goto :goto_1

    :cond_2
    const/4 v7, 0x0

    :goto_1
    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 259
    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getCode()Ljava/lang/Integer;

    move-result-object v5

    if-nez v5, :cond_3

    goto/16 :goto_4

    :cond_3
    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    if-nez v5, :cond_8

    .line 260
    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v2, :cond_7

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getMessage()Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

    move-result-object v2

    if-eqz v2, :cond_7

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->getContents()Ljava/util/List;

    move-result-object v2

    if-eqz v2, :cond_7

    .local v2, "contents":Ljava/util/List;
    const/4 v5, 0x0

    .line 262
    .local v5, "$i$a$-let-GHgIdentificationServiceImpl$handleAiMessage$1":I
    move-object v6, v2

    check-cast v6, Ljava/lang/Iterable;

    .local v6, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v7, 0x0

    .line 423
    .local v7, "$i$f$forEach":I
    invoke-interface {v6}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :goto_2
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_6

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    .local v9, "element$iv":Ljava/lang/Object;
    move-object/from16 v16, v9

    check-cast v16, Lcom/rokid/security/sdk/base/common/aichat/AiContent;

    .local v16, "content":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    const/16 v17, 0x0

    .line 264
    .local v17, "$i$a$-forEach-GHgIdentificationServiceImpl$handleAiMessage$1$1":I
    invoke-virtual/range {v16 .. v16}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getType()Ljava/lang/String;

    move-result-object v10

    const-string/jumbo v11, "text"

    invoke-static {v10, v11}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_4

    .line 265
    sget-object v10, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;

    const/4 v14, 0x0

    const-string v15, "Inputing"

    const-string v12, ""

    move-object/from16 v11, p1

    move-object/from16 v13, v16

    invoke-direct/range {v10 .. v15}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sendChatContent(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;)V

    goto :goto_3

    .line 266
    :cond_4
    invoke-virtual/range {v16 .. v16}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getType()Ljava/lang/String;

    move-result-object v10

    const-string/jumbo v11, "thinking"

    invoke-static {v10, v11}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_5

    .line 267
    sget-object v10, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;

    const/4 v14, 0x0

    const-string v15, "Thinking"

    const-string v12, ""

    move-object/from16 v11, p1

    move-object/from16 v13, v16

    invoke-direct/range {v10 .. v15}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sendChatContent(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;)V

    .line 270
    :cond_5
    :goto_3
    nop

    .line 423
    .end local v16    # "content":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .end local v17    # "$i$a$-forEach-GHgIdentificationServiceImpl$handleAiMessage$1$1":I
    nop

    .end local v9    # "element$iv":Ljava/lang/Object;
    goto :goto_2

    .line 424
    :cond_6
    nop

    .line 271
    .end local v6    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v7    # "$i$f$forEach":I
    nop

    .line 260
    .end local v2    # "contents":Ljava/util/List;
    .end local v5    # "$i$a$-let-GHgIdentificationServiceImpl$handleAiMessage$1":I
    :cond_7
    nop

    .line 272
    return v3

    .line 274
    :cond_8
    :goto_4
    sget-object v3, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "identification backend error code="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getCode()Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v3, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 275
    return v2
.end method

.method private final logIdentificationRequest(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 7
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "appId"    # Ljava/lang/String;
    .param p3, "question"    # Ljava/lang/String;
    .param p4, "imageBase64"    # Ljava/lang/String;
    .param p5, "payload"    # Ljava/lang/String;

    .line 220
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHeaders()Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v0

    const-string/jumbo v1, "x-user-authorization"

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_1

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    move v0, v1

    goto :goto_1

    :cond_1
    :goto_0
    move v0, v2

    :goto_1
    xor-int/2addr v0, v2

    .line 221
    .local v0, "hasUserHeader":Z
    sget-object v3, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHeaders()Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v3

    const-string/jumbo v4, "x-app-authorization"

    invoke-virtual {v3, v4}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/CharSequence;

    if-eqz v3, :cond_3

    invoke-static {v3}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_2

    goto :goto_2

    :cond_2
    move v3, v1

    goto :goto_3

    :cond_3
    :goto_2
    move v3, v2

    :goto_3
    xor-int/2addr v3, v2

    .line 222
    .local v3, "hasAppHeader":Z
    sget-object v4, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHeaders()Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v4

    const-string v5, "X-Agent"

    invoke-virtual {v4, v5}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    if-eqz v4, :cond_4

    invoke-static {v4}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_5

    :cond_4
    move v1, v2

    :cond_5
    xor-int/2addr v1, v2

    .line 224
    .local v1, "hasAgentHeader":Z
    sget-object v4, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    .line 225
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "identification request url="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " appId="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " update="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object v6, p3

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v6}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v6

    xor-int/2addr v6, v2

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " questionLength="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " hasImageBase64="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object v6, p4

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v6}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v6

    xor-int/2addr v2, v6

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, " payloadLength="

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p5}, Ljava/lang/String;->length()I

    move-result v5

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, " headers[user="

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, ", app="

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, ", agent="

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v5, 0x5d

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    .line 223
    invoke-static {v4, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 227
    return-void
.end method

.method private final nextMirrorSeq(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "questionId"    # Ljava/lang/String;
    .param p2, "event"    # Ljava/lang/String;

    .line 402
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    if-nez p1, :cond_0

    const-string v1, ""

    goto :goto_0

    :cond_0
    move-object v1, p1

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x3a

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->mirrorSeq:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private final sanitizeLargePayloadLog(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p1, "msg"    # Ljava/lang/String;

    .line 408
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "imageBase64"

    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x1

    invoke-static {v0, v2, v3}, Lkotlin/text/StringsKt;->contains(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    move-result v0

    const-string v2, "fileBase64"

    if-nez v0, :cond_0

    .line 409
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    move-object v4, v2

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v0, v4, v3}, Lkotlin/text/StringsKt;->contains(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    move-result v0

    if-nez v0, :cond_0

    .line 410
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v4, 0x400

    if-gt v0, v4, :cond_0

    .line 412
    return-object p1

    .line 414
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "length="

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, ", containsImageBase64="

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object v4, p1

    check-cast v4, Ljava/lang/CharSequence;

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v4, v1, v3}, Lkotlin/text/StringsKt;->contains(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", containsFileBase64="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object v1, p1

    check-cast v1, Ljava/lang/CharSequence;

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v1, v2, v3}, Lkotlin/text/StringsKt;->contains(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private final sendChatContent(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;)V
    .locals 10
    .param p1, "questionId"    # Ljava/lang/String;
    .param p2, "imageUrl"    # Ljava/lang/String;
    .param p3, "content"    # Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .param p4, "isFinish"    # Z
    .param p5, "inputType"    # Ljava/lang/String;

    .line 301
    sget-object v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "sendChatContent-->"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    if-eqz p3, :cond_0

    invoke-virtual {p3}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 303
    new-instance v0, Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;-><init>()V

    .line 304
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    const-string v1, "onResponse"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setMethodName(Ljava/lang/String;)V

    .line 305
    invoke-virtual {v0, p5}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setContentType(Ljava/lang/String;)V

    .line 306
    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setQuestionId(Ljava/lang/String;)V

    .line 307
    const-string v1, "glass_wifi_direct"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setSource(Ljava/lang/String;)V

    .line 309
    if-eqz p3, :cond_1

    .line 310
    invoke-virtual {p3}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setAnswer(Ljava/lang/String;)V

    .line 312
    :cond_1
    const-string v1, "Thinking"

    invoke-static {p5, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    const/4 v1, 0x0

    if-eqz p3, :cond_3

    invoke-virtual {p3}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_3

    check-cast v2, Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    const/4 v3, 0x1

    if-lez v2, :cond_2

    move v2, v3

    goto :goto_1

    :cond_2
    move v2, v1

    :goto_1
    if-ne v2, v3, :cond_3

    move v1, v3

    :cond_3
    if-eqz v1, :cond_4

    .line 313
    sget-object v1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->curAnswerContent:Ljava/lang/StringBuffer;

    invoke-virtual {p3}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 318
    :cond_4
    invoke-virtual {v0, p4}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setAnswerIsFinish(Z)V

    .line 319
    sget-object v1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 320
    .local v1, "extraStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "sendChatContent extraStr:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 321
    sget-object v2, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    const-string v3, "extraStr"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "HG_IDENTIFICATION_API_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalData$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 322
    invoke-direct {p0, v0}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sendMirrorResponse(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V

    .line 323
    return-void
.end method

.method static synthetic sendChatContent$default(Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;ILjava/lang/Object;)V
    .locals 6

    .line 300
    and-int/lit8 p6, p6, 0x2

    if-eqz p6, :cond_0

    const-string p2, ""

    :cond_0
    move-object v2, p2

    move-object v0, p0

    move-object v1, p1

    move-object v3, p3

    move v4, p4

    move-object v5, p5

    invoke-direct/range {v0 .. v5}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sendChatContent(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;)V

    return-void
.end method

.method private final sendError(Ljava/lang/String;)V
    .locals 10
    .param p1, "questionId"    # Ljava/lang/String;

    .line 284
    sget-object v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "sendError-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 288
    new-instance v0, Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendError_u24lambda_u244":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    const/4 v2, 0x0

    .line 289
    .local v2, "$i$a$-apply-GHgIdentificationServiceImpl$sendError$extra$1":I
    const-string v3, "onError"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setMethodName(Ljava/lang/String;)V

    .line 290
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setQuestionId(Ljava/lang/String;)V

    .line 291
    const-string v3, "glass_wifi_direct"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setSource(Ljava/lang/String;)V

    .line 292
    nop

    .line 288
    .end local v1    # "$this$sendError_u24lambda_u244":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    .end local v2    # "$i$a$-apply-GHgIdentificationServiceImpl$sendError$extra$1":I
    nop

    .line 293
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    sget-object v1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 294
    .local v1, "extraStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    const-string v3, "extraStr"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "HG_IDENTIFICATION_API_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalData$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 295
    invoke-direct {p0, v0}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sendMirrorError(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V

    .line 296
    return-void
.end method

.method static synthetic sendError$default(Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;Ljava/lang/String;ILjava/lang/Object;)V
    .locals 1

    .line 283
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_1

    sget-object p1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->currentQuestionId:Ljava/lang/String;

    move-object p2, p1

    .line 422
    .local p2, "it":Ljava/lang/String;
    const/4 p3, 0x0

    .line 283
    .local p3, "$i$a$-takeIf-GHgIdentificationServiceImpl$sendError$1":I
    move-object v0, p2

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    .end local p2    # "it":Ljava/lang/String;
    .end local p3    # "$i$a$-takeIf-GHgIdentificationServiceImpl$sendError$1":I
    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :cond_1
    :goto_0
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sendError(Ljava/lang/String;)V

    return-void
.end method

.method private final sendMirrorError(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V
    .locals 2
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    .line 388
    const-string v0, "mirrorError"

    invoke-virtual {p1, v0}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setMethodName(Ljava/lang/String;)V

    .line 389
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getQuestionId()Ljava/lang/String;

    move-result-object v0

    const-string v1, "error"

    invoke-direct {p0, v0, v1}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->nextMirrorSeq(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setMirrorSeq(Ljava/lang/String;)V

    .line 390
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sendMirrorExtra(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V

    .line 391
    return-void
.end method

.method private final sendMirrorExtra(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V
    .locals 9
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    .line 394
    sget-object v0, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    .line 395
    nop

    .line 396
    sget-object v1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const-string v1, "SenderHandler.mGson.toJson(extra)"

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 397
    nop

    .line 394
    const/16 v7, 0x38

    const/4 v8, 0x0

    const-string v1, "HG_IDENTIFICATION_MIRROR_ACTION"

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static/range {v0 .. v8}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalDataByNetworkMode$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 399
    return-void
.end method

.method private final sendMirrorImage(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V
    .locals 8
    .param p1, "questionId"    # Ljava/lang/String;
    .param p2, "requestExtra"    # Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    .line 345
    invoke-virtual {p2}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getImageBase64()Ljava/lang/String;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {p2}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getImageBase64()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lkotlin/text/StringsKt;->substringAfter(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 346
    .local v0, "imageBase64":Ljava/lang/String;
    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 347
    sget-object v1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendMirrorImage skipped empty imageBase64 questionId="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 348
    return-void

    .line 350
    :cond_0
    :try_start_0
    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v1, p0

    check-cast v1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;

    .local v1, "$this$sendMirrorImage_u24lambda_u246":Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;
    const/4 v2, 0x0

    .line 351
    .local v2, "$i$a$-runCatching-GHgIdentificationServiceImpl$sendMirrorImage$imageBytes$1":I
    const/4 v3, 0x2

    invoke-static {v0, v3}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v3

    .line 350
    .end local v1    # "$this$sendMirrorImage_u24lambda_u246":Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;
    .end local v2    # "$i$a$-runCatching-GHgIdentificationServiceImpl$sendMirrorImage$imageBytes$1":I
    invoke-static {v3}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    sget-object v2, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v1}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 352
    :goto_0
    invoke-static {v1}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v2

    if-nez v2, :cond_1

    check-cast v1, [B

    .line 350
    nop

    .line 356
    .local v1, "imageBytes":[B
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "HG_IDENTIFICATION_MIRROR_IMAGE:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x3a

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->mirrorSeq:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v3}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 357
    .local v2, "streamTag":Ljava/lang/String;
    new-instance v3, Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    invoke-direct {v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;-><init>()V

    move-object v4, v3

    .local v4, "$this$sendMirrorImage_u24lambda_u248":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    const/4 v5, 0x0

    .line 358
    .local v5, "$i$a$-apply-GHgIdentificationServiceImpl$sendMirrorImage$extra$1":I
    const-string v6, "mirrorImage"

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setMethodName(Ljava/lang/String;)V

    .line 359
    invoke-virtual {v4, p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setQuestionId(Ljava/lang/String;)V

    .line 360
    invoke-virtual {v4, v2}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setImageStreamTag(Ljava/lang/String;)V

    .line 361
    invoke-virtual {p2}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getAiImageType()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setAiImageType(Ljava/lang/String;)V

    .line 362
    invoke-virtual {p2}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getIdentificationId()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setIdentificationId(Ljava/lang/String;)V

    .line 363
    const-string v6, "glass_wifi_direct"

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setSource(Ljava/lang/String;)V

    .line 364
    sget-object v6, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;

    const-string v7, "image"

    invoke-direct {v6, p1, v7}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->nextMirrorSeq(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setMirrorSeq(Ljava/lang/String;)V

    .line 365
    nop

    .line 357
    .end local v4    # "$this$sendMirrorImage_u24lambda_u248":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    .end local v5    # "$i$a$-apply-GHgIdentificationServiceImpl$sendMirrorImage$extra$1":I
    nop

    .line 366
    .local v3, "extra":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    invoke-direct {p0, v3}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sendMirrorExtra(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V

    .line 367
    sget-object v4, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    const-string v5, "imageBytes"

    invoke-static {v1, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v5, 0x0

    invoke-virtual {v4, v2, v1, v5}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendStreamDataByNetworkMode(Ljava/lang/String;[BI)V

    .line 368
    return-void

    .line 352
    .end local v1    # "imageBytes":[B
    .end local v2    # "streamTag":Ljava/lang/String;
    .end local v3    # "extra":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    :cond_1
    move-object v1, v2

    .local v1, "it":Ljava/lang/Throwable;
    const/4 v2, 0x0

    .line 353
    .local v2, "$i$a$-getOrElse-GHgIdentificationServiceImpl$sendMirrorImage$imageBytes$2":I
    sget-object v3, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "sendMirrorImage decode failed questionId="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " message="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 354
    return-void
.end method

.method private final sendMirrorModify(Ljava/lang/String;)V
    .locals 5
    .param p1, "questionId"    # Ljava/lang/String;

    .line 371
    new-instance v0, Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendMirrorModify_u24lambda_u249":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    const/4 v2, 0x0

    .line 372
    .local v2, "$i$a$-apply-GHgIdentificationServiceImpl$sendMirrorModify$extra$1":I
    const-string v3, "mirrorModify"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setMethodName(Ljava/lang/String;)V

    .line 373
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setQuestionId(Ljava/lang/String;)V

    .line 374
    const/4 v3, 0x1

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setModify(Z)V

    .line 375
    const-string v3, "glass_wifi_direct"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setSource(Ljava/lang/String;)V

    .line 376
    sget-object v3, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;

    const-string v4, "modify"

    invoke-direct {v3, p1, v4}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->nextMirrorSeq(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setMirrorSeq(Ljava/lang/String;)V

    .line 377
    nop

    .line 371
    .end local v1    # "$this$sendMirrorModify_u24lambda_u249":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    .end local v2    # "$i$a$-apply-GHgIdentificationServiceImpl$sendMirrorModify$extra$1":I
    nop

    .line 378
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    invoke-direct {p0, v0}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sendMirrorExtra(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V

    .line 379
    return-void
.end method

.method private final sendMirrorQuestion(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V
    .locals 5
    .param p1, "questionId"    # Ljava/lang/String;
    .param p2, "question"    # Ljava/lang/String;
    .param p3, "imageUrl"    # Ljava/lang/String;
    .param p4, "requestExtra"    # Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    .line 331
    new-instance v0, Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendMirrorQuestion_u24lambda_u245":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    const/4 v2, 0x0

    .line 332
    .local v2, "$i$a$-apply-GHgIdentificationServiceImpl$sendMirrorQuestion$extra$1":I
    const-string v3, "mirrorQuestion"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setMethodName(Ljava/lang/String;)V

    .line 333
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setQuestionId(Ljava/lang/String;)V

    .line 334
    invoke-virtual {v1, p2}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setQuestion(Ljava/lang/String;)V

    .line 335
    if-nez p3, :cond_0

    const-string v3, ""

    goto :goto_0

    :cond_0
    move-object v3, p3

    :goto_0
    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setImageUrl(Ljava/lang/String;)V

    .line 336
    invoke-virtual {p4}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getAiImageType()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setAiImageType(Ljava/lang/String;)V

    .line 337
    invoke-virtual {p4}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getIdentificationId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setIdentificationId(Ljava/lang/String;)V

    .line 338
    const-string v3, "glass_wifi_direct"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setSource(Ljava/lang/String;)V

    .line 339
    sget-object v3, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;

    const-string v4, "question"

    invoke-direct {v3, p1, v4}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->nextMirrorSeq(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setMirrorSeq(Ljava/lang/String;)V

    .line 340
    nop

    .line 331
    .end local v1    # "$this$sendMirrorQuestion_u24lambda_u245":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    .end local v2    # "$i$a$-apply-GHgIdentificationServiceImpl$sendMirrorQuestion$extra$1":I
    nop

    .line 341
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    invoke-direct {p0, v0}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sendMirrorExtra(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V

    .line 342
    return-void
.end method

.method private final sendMirrorResponse(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V
    .locals 2
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    .line 382
    const-string v0, "mirrorResponse"

    invoke-virtual {p1, v0}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setMethodName(Ljava/lang/String;)V

    .line 383
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getQuestionId()Ljava/lang/String;

    move-result-object v0

    const-string v1, "response"

    invoke-direct {p0, v0, v1}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->nextMirrorSeq(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setMirrorSeq(Ljava/lang/String;)V

    .line 384
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sendMirrorExtra(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V

    .line 385
    return-void
.end method


# virtual methods
.method public final getMOkHttpSSEClient()Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;
    .locals 1

    .line 49
    sget-object v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    return-object v0
.end method

.method public final identificationEnd()V
    .locals 8

    .line 233
    sget-object v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    const-string v1, "identificationEnd"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 234
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v2

    new-instance v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$identificationEnd$1;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$identificationEnd$1;-><init>(Lkotlin/coroutines/Continuation;)V

    move-object v5, v0

    check-cast v5, Lkotlin/jvm/functions/Function2;

    const/4 v6, 0x3

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static/range {v2 .. v7}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 245
    return-void
.end method

.method public final initIdentification()V
    .locals 2

    .line 61
    sget-object v0, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageReceiver;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->getMessageAction()Lcom/rokid/security/sdk/ability/message/IMessageAction;

    move-result-object v0

    move-object v1, p0

    check-cast v1, Lcom/rokid/security/sdk/ability/message/ICommonMessage;

    invoke-interface {v0, v1}, Lcom/rokid/security/sdk/ability/message/IMessageAction;->injectIMessage(Lcom/rokid/security/sdk/ability/message/ICommonMessage;)V

    .line 63
    new-instance v0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    .line 64
    return-void
.end method

.method public onAudioStream([BI)V
    .locals 0
    .param p1, "buffer"    # [B
    .param p2, "type"    # I

    .line 46
    invoke-static {p0, p1, p2}, Lcom/rokid/security/sdk/ability/message/ICommonMessage$DefaultImpls;->onAudioStream(Lcom/rokid/security/sdk/ability/message/ICommonMessage;[BI)V

    return-void
.end method

.method public onMessage(Ljava/lang/String;I)V
    .locals 5
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "type"    # I

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 69
    sget-object v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onMessage "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sanitizeLargePayloadLog(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " type:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 70
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "HG_IDENTIFICATION_API_ACTION"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x2

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {v0, v1, v4, v2, v3}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 71
    sget-object v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onMessage:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sanitizeLargePayloadLog(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x20

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 72
    sget-object v0, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    const-class v1, Lcom/rokid/security/sdk/base/common/RkBaseData;

    invoke-virtual {v0, p1, v1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData;

    .line 73
    .local v0, "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    sget-object v1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData;->getExtra()Ljava/lang/String;

    move-result-object v2

    const-class v3, Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    invoke-virtual {v1, v2, v3}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    .line 75
    .local v1, "mIdentificationExtraExtra":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "execute"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    const-string v3, "mIdentificationExtraExtra"

    if-eqz v2, :cond_0

    .line 76
    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0, v1}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->toIdentification(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V

    goto :goto_0

    .line 77
    :cond_0
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    const-string v4, "modifyExecute"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 78
    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0, v1}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->toIdentification(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V

    goto :goto_0

    .line 79
    :cond_1
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    const-string/jumbo v3, "stopTask"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 80
    sget-object v2, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    if-eqz v2, :cond_4

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->close()V

    goto :goto_0

    .line 81
    :cond_2
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "end"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 82
    sget-object v2, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    if-eqz v2, :cond_3

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->close()V

    .line 83
    :cond_3
    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->identificationEnd()V

    .line 87
    .end local v0    # "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    .end local v1    # "mIdentificationExtraExtra":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    :cond_4
    :goto_0
    return-void
.end method

.method public onVideoStream([BI)V
    .locals 0
    .param p1, "buffer"    # [B
    .param p2, "type"    # I

    .line 46
    invoke-static {p0, p1, p2}, Lcom/rokid/security/sdk/ability/message/ICommonMessage$DefaultImpls;->onVideoStream(Lcom/rokid/security/sdk/ability/message/ICommonMessage;[BI)V

    return-void
.end method

.method public final setMOkHttpSSEClient(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    .line 49
    sput-object p1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    return-void
.end method

.method public final toIdentification(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V
    .locals 25
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    move-object/from16 v0, p0

    move-object/from16 v9, p1

    const-string v1, "extra"

    invoke-static {v9, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 95
    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    sput-object v1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->curAnswerContent:Ljava/lang/StringBuffer;

    .line 96
    new-instance v1, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v10, v1

    .local v10, "question":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getQuestion()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v10, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 97
    new-instance v1, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v11, v1

    .local v11, "imageUrl":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getImageUrl()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 98
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getImagePath()Ljava/lang/String;

    move-result-object v12

    .line 99
    .local v12, "imgPath":Ljava/lang/String;
    new-instance v1, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v13, v1

    .local v13, "identificationId":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getIdentificationId()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v13, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 101
    iget-object v1, v13, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 102
    sget-object v1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v2, "toIdentification aborted: identificationId is blank"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 103
    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sendError(Ljava/lang/String;)V

    .line 104
    return-void

    .line 107
    :cond_0
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getMethodName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "modifyExecute"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v14

    .line 108
    .local v14, "isModify":Z
    const/4 v1, 0x1

    if-eqz v14, :cond_1

    sget-object v2, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->currentQuestionId:Ljava/lang/String;

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    xor-int/2addr v2, v1

    if-eqz v2, :cond_1

    .line 109
    sget-object v2, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->currentQuestionId:Ljava/lang/String;

    goto :goto_0

    .line 111
    :cond_1
    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v3, v2

    .line 422
    .local v3, "it":Ljava/lang/String;
    const/4 v4, 0x0

    .line 111
    .local v4, "$i$a$-also-GHgIdentificationServiceImpl$toIdentification$questionId$1":I
    const-string v5, "it"

    invoke-static {v3, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sput-object v3, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->currentQuestionId:Ljava/lang/String;

    .line 110
    .end local v3    # "it":Ljava/lang/String;
    .end local v4    # "$i$a$-also-GHgIdentificationServiceImpl$toIdentification$questionId$1":I
    const-string/jumbo v3, "{\n            UUID.rando\u2026estionId = it }\n        }"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 108
    :goto_0
    move-object v15, v2

    .line 113
    .local v15, "questionId":Ljava/lang/String;
    new-instance v2, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v2}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v8, v2

    .local v8, "aiChatParam":Lkotlin/jvm/internal/Ref$ObjectRef;
    new-instance v2, Lcom/rokid/security/sdk/ability/param/AiChatParam;

    invoke-direct {v2}, Lcom/rokid/security/sdk/ability/param/AiChatParam;-><init>()V

    iput-object v2, v8, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 114
    iget-object v2, v8, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Lcom/rokid/security/sdk/ability/param/AiChatParam;

    iget-object v3, v13, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v2, v3}, Lcom/rokid/security/sdk/ability/param/AiChatParam;->setAppId(Ljava/lang/String;)V

    .line 115
    iget-object v2, v8, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Lcom/rokid/security/sdk/ability/param/AiChatParam;

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    check-cast v3, Ljava/util/List;

    invoke-virtual {v2, v3}, Lcom/rokid/security/sdk/ability/param/AiChatParam;->setMessages(Ljava/util/List;)V

    .line 117
    new-instance v2, Lcom/rokid/security/sdk/ability/param/AiMessages;

    invoke-direct {v2}, Lcom/rokid/security/sdk/ability/param/AiMessages;-><init>()V

    move-object v7, v2

    .line 118
    .local v7, "mAiMessages":Lcom/rokid/security/sdk/ability/param/AiMessages;
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    check-cast v2, Ljava/util/List;

    invoke-virtual {v7, v2}, Lcom/rokid/security/sdk/ability/param/AiMessages;->setContents(Ljava/util/List;)V

    .line 119
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getQuestion()Ljava/lang/String;

    move-result-object v2

    const-string v3, ""

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    .line 120
    sget-object v2, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "toIdentification-->)"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getQuestion()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 121
    iget-object v2, v8, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Lcom/rokid/security/sdk/ability/param/AiChatParam;

    invoke-virtual {v2, v1}, Lcom/rokid/security/sdk/ability/param/AiChatParam;->setUpdate(Z)V

    .line 124
    :cond_2
    sget-object v2, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "toIdentification-->"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, v10, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v4, Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0x20

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v5, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v5, Ljava/lang/String;

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, " identificationId:"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v5, v13, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v5, Ljava/lang/String;

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, v8, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v4, Lcom/rokid/security/sdk/ability/param/AiChatParam;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/param/AiChatParam;->getUpdate()Z

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 125
    new-instance v2, Lcom/rokid/security/sdk/ability/param/AiContent;

    invoke-direct {v2}, Lcom/rokid/security/sdk/ability/param/AiContent;-><init>()V

    move-object v6, v2

    .line 126
    .local v6, "textAiContent":Lcom/rokid/security/sdk/ability/param/AiContent;
    iget-object v2, v10, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v6, v2}, Lcom/rokid/security/sdk/ability/param/AiContent;->setText(Ljava/lang/String;)V

    .line 127
    const-string/jumbo v2, "text"

    invoke-virtual {v6, v2}, Lcom/rokid/security/sdk/ability/param/AiContent;->setType(Ljava/lang/String;)V

    .line 130
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getImageBase64()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-lez v2, :cond_3

    goto :goto_1

    :cond_3
    const/4 v1, 0x0

    :goto_1
    if-eqz v1, :cond_4

    .line 131
    new-instance v1, Lcom/rokid/security/sdk/ability/param/AiContent;

    invoke-direct {v1}, Lcom/rokid/security/sdk/ability/param/AiContent;-><init>()V

    .line 132
    .local v1, "imgAiContent":Lcom/rokid/security/sdk/ability/param/AiContent;
    const-string v2, "image_base64"

    invoke-virtual {v1, v2}, Lcom/rokid/security/sdk/ability/param/AiContent;->setType(Ljava/lang/String;)V

    .line 133
    const-string v2, "image/jpeg"

    invoke-virtual {v1, v2}, Lcom/rokid/security/sdk/ability/param/AiContent;->setMimeType(Ljava/lang/String;)V

    .line 134
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getImageBase64()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/rokid/security/sdk/ability/param/AiContent;->setData(Ljava/lang/String;)V

    .line 135
    invoke-virtual {v7}, Lcom/rokid/security/sdk/ability/param/AiMessages;->getContents()Ljava/util/List;

    move-result-object v2

    if-eqz v2, :cond_4

    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 140
    .end local v1    # "imgAiContent":Lcom/rokid/security/sdk/ability/param/AiContent;
    :cond_4
    invoke-virtual {v7}, Lcom/rokid/security/sdk/ability/param/AiMessages;->getContents()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_5

    invoke-interface {v1, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 141
    :cond_5
    iget-object v1, v8, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Lcom/rokid/security/sdk/ability/param/AiChatParam;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/param/AiChatParam;->getMessages()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_6

    invoke-interface {v1, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 144
    :cond_6
    sget-object v1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "onChatAi-->"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v10, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 145
    if-eqz v14, :cond_7

    .line 146
    invoke-direct {v0, v15}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sendMirrorModify(Ljava/lang/String;)V

    goto :goto_2

    .line 148
    :cond_7
    iget-object v1, v10, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    iget-object v2, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    invoke-direct {v0, v15, v1, v2, v9}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sendMirrorQuestion(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V

    .line 149
    invoke-direct {v0, v15, v9}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->sendMirrorImage(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V

    .line 151
    :goto_2
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v16

    new-instance v17, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;

    const/16 v18, 0x0

    move-object/from16 v1, v17

    move-object v2, v15

    move-object v3, v8

    move-object v4, v13

    move-object v5, v10

    move-object/from16 v22, v6

    .end local v6    # "textAiContent":Lcom/rokid/security/sdk/ability/param/AiContent;
    .local v22, "textAiContent":Lcom/rokid/security/sdk/ability/param/AiContent;
    move-object/from16 v6, p1

    move-object/from16 v23, v7

    .end local v7    # "mAiMessages":Lcom/rokid/security/sdk/ability/param/AiMessages;
    .local v23, "mAiMessages":Lcom/rokid/security/sdk/ability/param/AiMessages;
    move-object v7, v11

    move-object/from16 v24, v8

    .end local v8    # "aiChatParam":Lkotlin/jvm/internal/Ref$ObjectRef;
    .local v24, "aiChatParam":Lkotlin/jvm/internal/Ref$ObjectRef;
    move-object/from16 v8, v18

    invoke-direct/range {v1 .. v8}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;-><init>(Ljava/lang/String;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/sdk/base/common/IdentificationExtra;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/coroutines/Continuation;)V

    move-object/from16 v19, v17

    check-cast v19, Lkotlin/jvm/functions/Function2;

    const/16 v20, 0x3

    const/16 v21, 0x0

    const/16 v17, 0x0

    invoke-static/range {v16 .. v21}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 211
    return-void
.end method
