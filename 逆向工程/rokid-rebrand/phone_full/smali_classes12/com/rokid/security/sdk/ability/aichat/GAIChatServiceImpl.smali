.class public final Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;
.super Ljava/lang/Object;
.source "GAIChatServiceImpl.kt"

# interfaces
.implements Lcom/rokid/security/sdk/ability/message/ICommonMessage;


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nGAIChatServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 GAIChatServiceImpl.kt\ncom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,780:1\n1855#2,2:781\n1855#2,2:783\n1855#2,2:786\n1#3:785\n*S KotlinDebug\n*F\n+ 1 GAIChatServiceImpl.kt\ncom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl\n*L\n405#1:781,2\n420#1:783,2\n504#1:786,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000t\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0010\u000b\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u000b\n\u0002\u0010\u0000\n\u0002\u0008\u000e\n\u0002\u0018\u0002\n\u0002\u0008\u0008\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0012\u0010\'\u001a\u0004\u0018\u00010(2\u0006\u0010)\u001a\u00020*H\u0002J\u0012\u0010+\u001a\u0004\u0018\u00010\u00062\u0006\u0010,\u001a\u00020\u0006H\u0002J\u0010\u0010-\u001a\u00020.2\u0006\u0010/\u001a\u00020\u0006H\u0002J0\u0010-\u001a\u00020.2\n\u0008\u0002\u00100\u001a\u0004\u0018\u00010\u00062\n\u0008\u0002\u0010,\u001a\u0004\u0018\u00010\u00062\u0006\u00101\u001a\u00020\u00062\u0006\u0010/\u001a\u00020\u0006H\u0002J\u0010\u00102\u001a\u00020.2\u0006\u0010/\u001a\u00020\u0006H\u0002J\u0006\u00103\u001a\u00020.J\u001a\u00104\u001a\u00020\u00062\u0008\u00101\u001a\u0004\u0018\u00010\u00062\u0006\u00105\u001a\u00020\u0006H\u0002J\u000e\u00106\u001a\u00020.2\u0006\u00107\u001a\u00020\u0006J\u0018\u00106\u001a\u00020.2\u0006\u0010/\u001a\u00020\u00062\u0006\u00108\u001a\u00020\tH\u0016J\u0010\u00109\u001a\u00020:2\u0006\u0010;\u001a\u00020\u0006H\u0002J\u0012\u0010<\u001a\u00020\u00062\u0008\u0010=\u001a\u0004\u0018\u00010\u0006H\u0002J\u0012\u0010>\u001a\u00020\u00062\u0008\u0010?\u001a\u0004\u0018\u00010\u0006H\u0002J\u001a\u0010@\u001a\u00020.2\u0008\u0010A\u001a\u0004\u0018\u00010(2\u0006\u0010B\u001a\u00020\u0013H\u0002JF\u0010@\u001a\u00020.2\n\u0008\u0002\u00100\u001a\u0004\u0018\u00010\u00062\n\u0008\u0002\u0010,\u001a\u0004\u0018\u00010\u00062\u0006\u00101\u001a\u00020\u00062\u0008\u0010A\u001a\u0004\u0018\u00010(2\u0006\u0010B\u001a\u00020\u00132\n\u0008\u0002\u0010C\u001a\u0004\u0018\u00010\u0006H\u0002J\u0018\u0010D\u001a\u00020.2\u0006\u0010E\u001a\u00020\u00062\u0006\u00100\u001a\u00020\u0006H\u0002J\u0014\u0010F\u001a\u00020.2\n\u0008\u0002\u00101\u001a\u0004\u0018\u00010\u0006H\u0002J\u0010\u0010G\u001a\u00020.2\u0006\u0010H\u001a\u00020IH\u0002J\u0010\u0010J\u001a\u00020.2\u0006\u0010H\u001a\u00020IH\u0002J\u0018\u0010K\u001a\u00020.2\u0006\u00101\u001a\u00020\u00062\u0006\u0010L\u001a\u00020IH\u0002J*\u0010M\u001a\u00020.2\u0006\u00101\u001a\u00020\u00062\u0006\u00100\u001a\u00020\u00062\u0008\u0010,\u001a\u0004\u0018\u00010\u00062\u0006\u0010L\u001a\u00020IH\u0002J\u0010\u0010N\u001a\u00020.2\u0006\u0010H\u001a\u00020IH\u0002J\u0018\u0010O\u001a\u00020.2\u0006\u0010H\u001a\u00020I2\u0008\u0008\u0002\u0010\u0012\u001a\u00020\u0013J\u000e\u0010P\u001a\u00020.2\u0006\u0010H\u001a\u00020IR\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0006X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\tX\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u0006X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\u000cX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001a\u0010\r\u001a\u00020\u0006X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000e\u0010\u000f\"\u0004\u0008\u0010\u0010\u0011R\u001a\u0010\u0012\u001a\u00020\u0013X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0012\u0010\u0014\"\u0004\u0008\u0015\u0010\u0016R\u001a\u0010\u0017\u001a\u00020\u0018X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0019\u0010\u001a\"\u0004\u0008\u001b\u0010\u001cR\u001c\u0010\u001d\u001a\u0004\u0018\u00010\u001eX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001f\u0010 \"\u0004\u0008!\u0010\"R\u000e\u0010#\u001a\u00020$X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010%\u001a\u000e\u0012\u0004\u0012\u00020\u0006\u0012\u0004\u0012\u00020\u00060&X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006Q"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;",
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
        "guideSessionId",
        "getGuideSessionId",
        "()Ljava/lang/String;",
        "setGuideSessionId",
        "(Ljava/lang/String;)V",
        "isCustom",
        "",
        "()Z",
        "setCustom",
        "(Z)V",
        "mGson",
        "Lcom/google/gson/Gson;",
        "getMGson",
        "()Lcom/google/gson/Gson;",
        "setMGson",
        "(Lcom/google/gson/Gson;)V",
        "mOkHttpSSEClient",
        "Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;",
        "getMOkHttpSSEClient",
        "()Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;",
        "setMOkHttpSSEClient",
        "(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)V",
        "mirrorSeq",
        "Ljava/util/concurrent/atomic/AtomicLong;",
        "questionSessionIds",
        "Ljava/util/concurrent/ConcurrentHashMap;",
        "buildFunctionCallAiContent",
        "Lcom/rokid/security/sdk/base/common/aichat/AiContent;",
        "toolCall",
        "Lcom/rokid/security/sdk/base/common/aichat/ToolCall;",
        "convertImageUrlToBase64",
        "imageUrl",
        "handleAiMessage",
        "",
        "message",
        "question",
        "questionId",
        "handleInspectGuideMessage",
        "initAIChat",
        "nextMirrorSeq",
        "event",
        "onMessage",
        "msg",
        "type",
        "parseJsonOrRaw",
        "",
        "raw",
        "resolveChatStreamUrl",
        "streamVersion",
        "resolveChatStreamVersion",
        "requestedVersion",
        "sendChatContent",
        "content",
        "isFinish",
        "sessionId",
        "sendChatImgIntent",
        "intent",
        "sendError",
        "sendMirrorError",
        "extra",
        "Lcom/rokid/security/sdk/base/common/AiChatExtra;",
        "sendMirrorExtra",
        "sendMirrorImage",
        "requestExtra",
        "sendMirrorQuestion",
        "sendMirrorResponse",
        "toAiChat",
        "toProductRec",
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

.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

.field private static final MIRROR_IMAGE_STREAM_PREFIX:Ljava/lang/String; = "AI_CHAT_MIRROR_IMAGE:"

.field private static final MIRROR_SOURCE_GLASS_WIFI_DIRECT:Ljava/lang/String; = "glass_wifi_direct"

.field private static final PHONE_RELAY_NETWORK_MODE:I

.field private static final TAG:Ljava/lang/String;

.field private static curAnswerContent:Ljava/lang/StringBuffer;

.field private static guideSessionId:Ljava/lang/String;

.field private static isCustom:Z

.field private static mGson:Lcom/google/gson/Gson;

.field private static mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

.field private static final mirrorSeq:Ljava/util/concurrent/atomic/AtomicLong;

.field private static final questionSessionIds:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 3

    new-instance v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    .line 49
    const-string v0, "GAIChatServiceImpl::"

    sput-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    .line 59
    const-string v0, "default"

    sput-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->guideSessionId:Ljava/lang/String;

    .line 63
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->mGson:Lcom/google/gson/Gson;

    .line 68
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->curAnswerContent:Ljava/lang/StringBuffer;

    .line 69
    new-instance v0, Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v1, 0x0

    invoke-direct {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicLong;-><init>(J)V

    sput-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->mirrorSeq:Ljava/util/concurrent/atomic/AtomicLong;

    .line 70
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->questionSessionIds:Ljava/util/concurrent/ConcurrentHashMap;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$getQuestionSessionIds$p()Ljava/util/concurrent/ConcurrentHashMap;
    .locals 1

    .line 46
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->questionSessionIds:Ljava/util/concurrent/ConcurrentHashMap;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 46
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$handleAiMessage(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;
    .param p1, "message"    # Ljava/lang/String;

    .line 46
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->handleAiMessage(Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$handleAiMessage(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;
    .param p1, "question"    # Ljava/lang/String;
    .param p2, "imageUrl"    # Ljava/lang/String;
    .param p3, "questionId"    # Ljava/lang/String;
    .param p4, "message"    # Ljava/lang/String;

    .line 46
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->handleAiMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$resolveChatStreamUrl(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;
    .param p1, "streamVersion"    # Ljava/lang/String;

    .line 46
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->resolveChatStreamUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$resolveChatStreamVersion(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;
    .param p1, "requestedVersion"    # Ljava/lang/String;

    .line 46
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->resolveChatStreamVersion(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$sendChatContent(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;
    .param p1, "content"    # Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .param p2, "isFinish"    # Z

    .line 46
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendChatContent(Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V

    return-void
.end method

.method public static final synthetic access$sendChatContent(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;
    .param p1, "question"    # Ljava/lang/String;
    .param p2, "imageUrl"    # Ljava/lang/String;
    .param p3, "questionId"    # Ljava/lang/String;
    .param p4, "content"    # Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .param p5, "isFinish"    # Z
    .param p6, "sessionId"    # Ljava/lang/String;

    .line 46
    invoke-direct/range {p0 .. p6}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendChatContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$sendError(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;
    .param p1, "questionId"    # Ljava/lang/String;

    .line 46
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendError(Ljava/lang/String;)V

    return-void
.end method

.method private final buildFunctionCallAiContent(Lcom/rokid/security/sdk/base/common/aichat/ToolCall;)Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .locals 11
    .param p1, "toolCall"    # Lcom/rokid/security/sdk/base/common/aichat/ToolCall;

    .line 438
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->getFunction()Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;

    move-result-object v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    .line 439
    .local v0, "function":Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;
    :cond_0
    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;->getName()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    return-object v1

    .line 442
    :cond_1
    nop

    .line 443
    :try_start_0
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->getExtBody()Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;

    move-result-object v2

    if-eqz v2, :cond_2

    .line 785
    .local v2, "it":Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;
    const/4 v3, 0x0

    .line 443
    .local v3, "$i$a$-let-GAIChatServiceImpl$buildFunctionCallAiContent$extBodyJson$1":I
    new-instance v4, Lorg/json/JSONObject;

    sget-object v5, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->mGson:Lcom/google/gson/Gson;

    invoke-virtual {v5, v2}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .end local v2    # "it":Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;
    .end local v3    # "$i$a$-let-GAIChatServiceImpl$buildFunctionCallAiContent$extBodyJson$1":I
    goto :goto_0

    :cond_2
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 444
    :catch_0
    move-exception v2

    .line 445
    .local v2, "_":Ljava/lang/Exception;
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 442
    .end local v2    # "_":Ljava/lang/Exception;
    :goto_0
    move-object v2, v4

    .line 448
    .local v2, "extBodyJson":Lorg/json/JSONObject;
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->getExtBody()Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;

    move-result-object v3

    if-eqz v3, :cond_3

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;->getMode()Ljava/lang/String;

    move-result-object v1

    :cond_3
    if-nez v1, :cond_4

    const-string v1, ""

    .line 449
    .local v1, "mode":Ljava/lang/String;
    :cond_4
    const-string v3, "SCENE"

    const/4 v4, 0x1

    invoke-static {v1, v3, v4}, Lkotlin/text/StringsKt;->equals(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v3

    .line 451
    .local v3, "isScene":Z
    sget-object v4, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    .line 452
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "map tool_call id="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->getId()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " type="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->getType()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " function="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " isScene="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " argsLen="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;->getArguments()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    .line 450
    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 455
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    move-object v5, v4

    .local v5, "$this$buildFunctionCallAiContent_u24lambda_u244":Lorg/json/JSONObject;
    const/4 v6, 0x0

    .line 456
    .local v6, "$i$a$-apply-GAIChatServiceImpl$buildFunctionCallAiContent$payload$1":I
    const-string v7, "path"

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;->getName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 457
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->getExtBody()Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;

    move-result-object v7

    if-eqz v7, :cond_5

    invoke-virtual {v7}, Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;->getAixKey()Ljava/lang/String;

    move-result-object v7

    if-nez v7, :cond_6

    :cond_5
    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;->getName()Ljava/lang/String;

    move-result-object v7

    :cond_6
    const-string v8, "aixPath"

    invoke-virtual {v5, v8, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 458
    sget-object v7, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;->getArguments()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->parseJsonOrRaw(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v7

    const-string v8, "parameters"

    invoke-virtual {v5, v8, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 459
    const-string v7, "isScene"

    invoke-virtual {v5, v7, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 460
    const-string v7, "ext_body"

    invoke-virtual {v5, v7, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 461
    const-string/jumbo v7, "tool_call_id"

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->getId()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 462
    nop

    .line 455
    .end local v5    # "$this$buildFunctionCallAiContent_u24lambda_u244":Lorg/json/JSONObject;
    .end local v6    # "$i$a$-apply-GAIChatServiceImpl$buildFunctionCallAiContent$payload$1":I
    nop

    .line 463
    .local v4, "payload":Lorg/json/JSONObject;
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    move-object v6, v5

    .local v6, "$this$buildFunctionCallAiContent_u24lambda_u245":Lorg/json/JSONObject;
    const/4 v7, 0x0

    .line 464
    .local v7, "$i$a$-apply-GAIChatServiceImpl$buildFunctionCallAiContent$wrapped$1":I
    const-string/jumbo v8, "text"

    invoke-virtual {v4}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v6, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 465
    const-string v8, "contentType"

    const-string v9, "FunctionCall"

    invoke-virtual {v6, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 466
    nop

    .line 463
    .end local v6    # "$this$buildFunctionCallAiContent_u24lambda_u245":Lorg/json/JSONObject;
    .end local v7    # "$i$a$-apply-GAIChatServiceImpl$buildFunctionCallAiContent$wrapped$1":I
    nop

    .line 467
    .local v5, "wrapped":Lorg/json/JSONObject;
    new-instance v6, Lcom/rokid/security/sdk/base/common/aichat/AiContent;

    invoke-direct {v6}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;-><init>()V

    move-object v7, v6

    .local v7, "$this$buildFunctionCallAiContent_u24lambda_u246":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    const/4 v8, 0x0

    .line 468
    .local v8, "$i$a$-apply-GAIChatServiceImpl$buildFunctionCallAiContent$1":I
    invoke-virtual {v5}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v9

    const-string/jumbo v10, "wrapped.toString()"

    invoke-static {v9, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v7, v9}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->setText(Ljava/lang/String;)V

    .line 469
    nop

    .line 467
    .end local v7    # "$this$buildFunctionCallAiContent_u24lambda_u246":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .end local v8    # "$i$a$-apply-GAIChatServiceImpl$buildFunctionCallAiContent$1":I
    return-object v6
.end method

.method private final convertImageUrlToBase64(Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .param p1, "imageUrl"    # Ljava/lang/String;

    .line 749
    nop

    .line 751
    const/4 v0, 0x0

    :try_start_0
    const-string v1, "/"

    const/4 v2, 0x2

    const/4 v3, 0x0

    invoke-static {p1, v1, v3, v2, v0}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v4, "file://"

    if-nez v1, :cond_1

    :try_start_1
    invoke-static {p1, v4, v3, v2, v0}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 770
    :cond_0
    sget-object v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v2, "\u6682\u4e0d\u652f\u6301\u7f51\u7edc\u56fe\u7247URL\u8f6cbase64"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 771
    goto :goto_2

    .line 752
    :cond_1
    :goto_0
    invoke-static {p1, v4, v3, v2, v0}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 753
    const/4 v1, 0x7

    invoke-virtual {p1, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v4, "this as java.lang.String).substring(startIndex)"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    goto :goto_1

    .line 755
    :cond_2
    move-object v1, p1

    .line 752
    :goto_1
    nop

    .line 760
    .local v1, "filePath":Ljava/lang/String;
    new-instance v4, Ljava/io/File;

    invoke-direct {v4, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 761
    .local v4, "file":Ljava/io/File;
    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_3

    .line 763
    invoke-static {v4}, Lkotlin/io/FilesKt;->readBytes(Ljava/io/File;)[B

    move-result-object v3

    .line 764
    .local v3, "fileBytes":[B
    invoke-static {v3, v2}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v0

    .end local v3    # "fileBytes":[B
    goto :goto_2

    .line 766
    :cond_3
    sget-object v2, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "\u56fe\u7247\u6587\u4ef6\u4e0d\u5b58\u5728 pathPresent="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object v6, v1

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v6}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_4

    const/4 v3, 0x1

    :cond_4
    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 767
    nop

    .line 771
    .end local v1    # "filePath":Ljava/lang/String;
    .end local v4    # "file":Ljava/io/File;
    :goto_2
    goto :goto_3

    .line 773
    :catch_0
    move-exception v1

    .line 774
    .local v1, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "image conversion failed type="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 775
    nop

    .line 749
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_3
    return-object v0
.end method

.method private final handleAiMessage(Ljava/lang/String;)V
    .locals 7
    .param p1, "message"    # Ljava/lang/String;

    .line 564
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/4 v1, 0x1

    if-nez v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-eqz v0, :cond_1

    .line 565
    return-void

    .line 568
    :cond_1
    nop

    .line 570
    :try_start_0
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->mGson:Lcom/google/gson/Gson;

    const-class v2, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;

    invoke-virtual {v0, p1, v2}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    const-string v2, "mGson.fromJson(message, \u2026tifyResponse::class.java)"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;

    .line 571
    .local v0, "productResponse":Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;
    sget-object v2, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    const-string v3, "product recognition response parsed present=true"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 574
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u8bc6\u522b\u7ed3\u679c\uff1a\n\u5546\u54c1\u540d\u79f0\uff1a"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 575
    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->getName()Ljava/lang/String;

    move-result-object v3

    .line 574
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 575
    const-string v3, "\n\u54c1\u724c\uff1a"

    .line 574
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 576
    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->getBrand()Ljava/lang/String;

    move-result-object v3

    .line 574
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 576
    const-string v3, "\n\u5206\u7c7b\uff1a"

    .line 574
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 577
    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->getItemCategory()Ljava/lang/String;

    move-result-object v3

    .line 574
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 577
    const-string v3, " - "

    .line 574
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 577
    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->getSubItemCategory()Ljava/lang/String;

    move-result-object v3

    .line 574
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 577
    const-string v3, "\n\u4ef7\u683c\uff1a"

    .line 574
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 578
    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->getPrice()D

    move-result-wide v3

    .line 574
    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x20

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 578
    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->getUnit()Ljava/lang/String;

    move-result-object v3

    .line 574
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 578
    const-string v3, "\n\u89c4\u683c\uff1a"

    .line 574
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 579
    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->getSpecifications()Ljava/lang/String;

    move-result-object v3

    .line 574
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 579
    const-string v3, "\n\u6761\u5f62\u7801\uff1a"

    .line 574
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 580
    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->getBarcode()Ljava/lang/String;

    move-result-object v3

    .line 574
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 583
    .local v2, "responseText":Ljava/lang/String;
    new-instance v3, Lcom/rokid/security/sdk/base/common/aichat/AiContent;

    invoke-direct {v3}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;-><init>()V

    move-object v4, v3

    .local v4, "$this$handleAiMessage_u24lambda_u248":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    const/4 v5, 0x0

    .line 584
    .local v5, "$i$a$-apply-GAIChatServiceImpl$handleAiMessage$aiContent$1":I
    invoke-virtual {v4, v2}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->setText(Ljava/lang/String;)V

    .line 586
    sget-object v6, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->guideSessionId:Ljava/lang/String;

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->setSessionId(Ljava/lang/String;)V

    .line 587
    nop

    .line 583
    .end local v4    # "$this$handleAiMessage_u24lambda_u248":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .end local v5    # "$i$a$-apply-GAIChatServiceImpl$handleAiMessage$aiContent$1":I
    nop

    .line 588
    .local v3, "aiContent":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    invoke-direct {p0, v3, v1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendChatContent(Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "productResponse":Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;
    .end local v2    # "responseText":Ljava/lang/String;
    .end local v3    # "aiContent":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    goto :goto_1

    .line 590
    :catch_0
    move-exception v0

    .line 591
    .local v0, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "product recognition response parse failed type="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 592
    const/4 v2, 0x0

    invoke-static {p0, v2, v1, v2}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendError$default(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;ILjava/lang/Object;)V

    .line 594
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method private final handleAiMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 23
    .param p1, "question"    # Ljava/lang/String;
    .param p2, "imageUrl"    # Ljava/lang/String;
    .param p3, "questionId"    # Ljava/lang/String;
    .param p4, "message"    # Ljava/lang/String;

    .line 387
    move-object/from16 v7, p3

    move-object/from16 v8, p4

    move-object v0, v8

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/4 v9, 0x1

    const/4 v10, 0x0

    if-nez v0, :cond_0

    move v0, v9

    goto :goto_0

    :cond_0
    move v0, v10

    :goto_0
    if-eqz v0, :cond_1

    .line 388
    return-void

    .line 390
    :cond_1
    new-instance v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$handleAiMessage$type$1;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$handleAiMessage$type$1;-><init>()V

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$handleAiMessage$type$1;->getType()Ljava/lang/reflect/Type;

    move-result-object v11

    .line 391
    .local v11, "type":Ljava/lang/reflect/Type;
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->mGson:Lcom/google/gson/Gson;

    invoke-virtual {v0, v8, v11}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/reflect/Type;)Ljava/lang/Object;

    move-result-object v0

    const-string v1, "mGson.fromJson(message, type)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v12, v0

    check-cast v12, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;

    .line 392
    .local v12, "aiResponse":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onChatAi-->"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v12}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getCode()Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x20

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v12}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    const/4 v3, 0x0

    if-eqz v2, :cond_2

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getMessage()Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

    move-result-object v2

    if-eqz v2, :cond_2

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->getContents()Ljava/util/List;

    move-result-object v2

    if-eqz v2, :cond_2

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    goto :goto_1

    :cond_2
    move-object v2, v3

    :goto_1
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 393
    invoke-virtual {v12}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getCode()Ljava/lang/Integer;

    move-result-object v0

    if-nez v0, :cond_3

    goto/16 :goto_e

    :cond_3
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-nez v0, :cond_16

    .line 394
    invoke-virtual {v12}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v0, :cond_4

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getSessionId()Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    :cond_4
    move-object v0, v3

    :goto_2
    move-object v13, v0

    .line 395
    .local v13, "sessionId":Ljava/lang/String;
    move-object v0, v13

    check-cast v0, Ljava/lang/CharSequence;

    if-eqz v0, :cond_6

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_5

    goto :goto_3

    :cond_5
    move v0, v10

    goto :goto_4

    :cond_6
    :goto_3
    move v0, v9

    :goto_4
    if-nez v0, :cond_7

    .line 396
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->questionSessionIds:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v0, Ljava/util/Map;

    invoke-interface {v0, v7, v13}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 398
    :cond_7
    invoke-virtual {v12}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v0, :cond_8

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getMessage()Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

    move-result-object v0

    if-eqz v0, :cond_8

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->getToolCalls()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_8

    check-cast v0, Ljava/util/Collection;

    invoke-interface {v0}, Ljava/util/Collection;->isEmpty()Z

    move-result v0

    xor-int/2addr v0, v9

    if-ne v0, v9, :cond_8

    move v0, v9

    goto :goto_5

    :cond_8
    move v0, v10

    :goto_5
    move v14, v0

    .line 399
    .local v14, "hasToolCalls":Z
    if-eqz v14, :cond_e

    .line 400
    invoke-virtual {v12}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v0, :cond_9

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getOutputMetadata()Lcom/rokid/security/sdk/base/common/aichat/OutputMetadata;

    move-result-object v0

    if-eqz v0, :cond_9

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/OutputMetadata;->getFinishReason()Ljava/lang/String;

    move-result-object v3

    :cond_9
    if-nez v3, :cond_a

    const-string v3, ""

    :cond_a
    move-object v15, v3

    .line 402
    .local v15, "finishReason":Ljava/lang/String;
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    .line 403
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "v2 tool_calls received count="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v12}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v2, :cond_b

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getMessage()Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

    move-result-object v2

    if-eqz v2, :cond_b

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->getToolCalls()Ljava/util/List;

    move-result-object v2

    if-eqz v2, :cond_b

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    goto :goto_6

    :cond_b
    move v2, v10

    :goto_6
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " finishReason="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " questionId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    .line 401
    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 405
    invoke-virtual {v12}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v0, :cond_e

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getMessage()Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

    move-result-object v0

    if-eqz v0, :cond_e

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->getToolCalls()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_e

    move-object/from16 v16, v0

    check-cast v16, Ljava/lang/Iterable;

    .local v16, "$this$forEach$iv":Ljava/lang/Iterable;
    const/16 v17, 0x0

    .line 781
    .local v17, "$i$f$forEach":I
    invoke-interface/range {v16 .. v16}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v18

    :goto_7
    invoke-interface/range {v18 .. v18}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_d

    invoke-interface/range {v18 .. v18}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v19

    .local v19, "element$iv":Ljava/lang/Object;
    move-object/from16 v6, v19

    check-cast v6, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;

    .local v6, "toolCall":Lcom/rokid/security/sdk/base/common/aichat/ToolCall;
    const/16 v20, 0x0

    .line 406
    .local v20, "$i$a$-forEach-GAIChatServiceImpl$handleAiMessage$1":I
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    invoke-direct {v0, v6}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->buildFunctionCallAiContent(Lcom/rokid/security/sdk/base/common/aichat/ToolCall;)Lcom/rokid/security/sdk/base/common/aichat/AiContent;

    move-result-object v21

    .line 407
    .local v21, "functionCallContent":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    if-eqz v21, :cond_c

    .line 408
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    .line 409
    nop

    .line 410
    nop

    .line 411
    nop

    .line 412
    nop

    .line 413
    nop

    .line 414
    nop

    .line 408
    const/4 v5, 0x0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move-object/from16 v4, v21

    move-object/from16 v22, v6

    .end local v6    # "toolCall":Lcom/rokid/security/sdk/base/common/aichat/ToolCall;
    .local v22, "toolCall":Lcom/rokid/security/sdk/base/common/aichat/ToolCall;
    move-object v6, v13

    invoke-direct/range {v0 .. v6}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendChatContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;)V

    goto :goto_8

    .line 407
    .end local v22    # "toolCall":Lcom/rokid/security/sdk/base/common/aichat/ToolCall;
    .restart local v6    # "toolCall":Lcom/rokid/security/sdk/base/common/aichat/ToolCall;
    :cond_c
    move-object/from16 v22, v6

    .line 417
    .end local v6    # "toolCall":Lcom/rokid/security/sdk/base/common/aichat/ToolCall;
    .restart local v22    # "toolCall":Lcom/rokid/security/sdk/base/common/aichat/ToolCall;
    :goto_8
    nop

    .line 781
    .end local v20    # "$i$a$-forEach-GAIChatServiceImpl$handleAiMessage$1":I
    .end local v21    # "functionCallContent":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .end local v22    # "toolCall":Lcom/rokid/security/sdk/base/common/aichat/ToolCall;
    nop

    .end local v19    # "element$iv":Ljava/lang/Object;
    goto :goto_7

    .line 782
    :cond_d
    nop

    .line 419
    .end local v15    # "finishReason":Ljava/lang/String;
    .end local v16    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v17    # "$i$f$forEach":I
    :cond_e
    invoke-virtual {v12}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v0, :cond_15

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getMessage()Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

    move-result-object v0

    if-eqz v0, :cond_15

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->getContents()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_15

    move-object v15, v0

    .local v15, "contents":Ljava/util/List;
    const/16 v16, 0x0

    .line 420
    .local v16, "$i$a$-let-GAIChatServiceImpl$handleAiMessage$2":I
    move-object/from16 v17, v15

    check-cast v17, Ljava/lang/Iterable;

    .local v17, "$this$forEach$iv":Ljava/lang/Iterable;
    const/16 v18, 0x0

    .line 783
    .local v18, "$i$f$forEach":I
    invoke-interface/range {v17 .. v17}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v19

    :goto_9
    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_14

    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v20

    .local v20, "element$iv":Ljava/lang/Object;
    move-object/from16 v6, v20

    check-cast v6, Lcom/rokid/security/sdk/base/common/aichat/AiContent;

    .local v6, "it":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    const/16 v21, 0x0

    .line 421
    .local v21, "$i$a$-forEach-GAIChatServiceImpl$handleAiMessage$2$1":I
    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getSessionId()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    if-eqz v0, :cond_10

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_f

    goto :goto_a

    :cond_f
    move v0, v10

    goto :goto_b

    :cond_10
    :goto_a
    move v0, v9

    :goto_b
    if-eqz v0, :cond_13

    move-object v0, v13

    check-cast v0, Ljava/lang/CharSequence;

    if-eqz v0, :cond_12

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_11

    goto :goto_c

    :cond_11
    move v0, v10

    goto :goto_d

    :cond_12
    :goto_c
    move v0, v9

    :goto_d
    if-nez v0, :cond_13

    .line 422
    invoke-virtual {v6, v13}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->setSessionId(Ljava/lang/String;)V

    .line 424
    :cond_13
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    .line 425
    nop

    .line 426
    nop

    .line 427
    nop

    .line 428
    nop

    .line 429
    nop

    .line 430
    nop

    .line 424
    const/4 v5, 0x0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move-object v4, v6

    move-object/from16 v22, v6

    .end local v6    # "it":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .local v22, "it":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    move-object v6, v13

    invoke-direct/range {v0 .. v6}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendChatContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;)V

    .line 432
    nop

    .line 783
    .end local v21    # "$i$a$-forEach-GAIChatServiceImpl$handleAiMessage$2$1":I
    .end local v22    # "it":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    nop

    .end local v20    # "element$iv":Ljava/lang/Object;
    goto :goto_9

    .line 784
    :cond_14
    nop

    .line 433
    .end local v17    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v18    # "$i$f$forEach":I
    nop

    .line 419
    .end local v15    # "contents":Ljava/util/List;
    .end local v16    # "$i$a$-let-GAIChatServiceImpl$handleAiMessage$2":I
    :cond_15
    nop

    .line 435
    .end local v13    # "sessionId":Ljava/lang/String;
    .end local v14    # "hasToolCalls":Z
    :cond_16
    :goto_e
    return-void
.end method

.method static synthetic handleAiMessage$default(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    .locals 1

    .line 386
    and-int/lit8 p6, p5, 0x1

    const-string v0, ""

    if-eqz p6, :cond_0

    move-object p1, v0

    :cond_0
    and-int/lit8 p5, p5, 0x2

    if-eqz p5, :cond_1

    move-object p2, v0

    :cond_1
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->handleAiMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private final handleInspectGuideMessage(Ljava/lang/String;)V
    .locals 14
    .param p1, "message"    # Ljava/lang/String;

    .line 486
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-nez v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    move v0, v2

    :goto_0
    if-eqz v0, :cond_1

    .line 487
    return-void

    .line 490
    :cond_1
    nop

    .line 491
    const/4 v0, 0x0

    :try_start_0
    sget-object v3, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "inspect guide response received chars="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 495
    sget-object v3, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->mGson:Lcom/google/gson/Gson;

    new-instance v4, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$handleInspectGuideMessage$response$1;

    invoke-direct {v4}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$handleInspectGuideMessage$response$1;-><init>()V

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$handleInspectGuideMessage$response$1;->getType()Ljava/lang/reflect/Type;

    move-result-object v4

    invoke-virtual {v3, p1, v4}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/reflect/Type;)Ljava/lang/Object;

    move-result-object v3

    const-string v4, "mGson.fromJson(message, \u20263<AIResponse>>() {}.type)"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v3, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;

    .line 494
    nop

    .line 496
    .local v3, "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v4, :cond_2

    invoke-virtual {v4}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getSessionId()Ljava/lang/String;

    move-result-object v4

    goto :goto_1

    :cond_2
    move-object v4, v0

    .line 499
    .local v4, "sessionId":Ljava/lang/String;
    :goto_1
    move-object v5, v4

    check-cast v5, Ljava/lang/CharSequence;

    if-eqz v5, :cond_4

    invoke-interface {v5}, Ljava/lang/CharSequence;->length()I

    move-result v5

    if-nez v5, :cond_3

    goto :goto_2

    :cond_3
    move v5, v2

    goto :goto_3

    :cond_4
    :goto_2
    move v5, v1

    :goto_3
    if-nez v5, :cond_5

    const-string v5, "default"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_5

    .line 500
    sput-object v4, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->guideSessionId:Ljava/lang/String;

    .line 501
    sget-object v5, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    const-string v6, "inspect guide audio session updated present=true"

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 504
    :cond_5
    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v5, :cond_8

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getMessage()Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

    move-result-object v5

    if-eqz v5, :cond_8

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->getContents()Ljava/util/List;

    move-result-object v5

    if-eqz v5, :cond_8

    check-cast v5, Ljava/lang/Iterable;

    .local v5, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v6, 0x0

    .line 786
    .local v6, "$i$f$forEach":I
    invoke-interface {v5}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_4
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_7

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    .local v8, "element$iv":Ljava/lang/Object;
    move-object v9, v8

    check-cast v9, Lcom/rokid/security/sdk/base/common/aichat/AiContent;

    .local v9, "it":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    const/4 v10, 0x0

    .line 505
    .local v10, "$i$a$-forEach-GAIChatServiceImpl$handleInspectGuideMessage$1":I
    sget-object v11, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "inspect guide content received chars="

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v9}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v13

    if-eqz v13, :cond_6

    invoke-virtual {v13}, Ljava/lang/String;->length()I

    move-result v13

    goto :goto_5

    :cond_6
    move v13, v2

    :goto_5
    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    filled-new-array {v12}, [Ljava/lang/Object;

    move-result-object v12

    invoke-static {v11, v12}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 506
    sget-object v11, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->guideSessionId:Ljava/lang/String;

    invoke-virtual {v9, v11}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->setSessionId(Ljava/lang/String;)V

    .line 507
    sget-object v11, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->GUIDE:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    invoke-virtual {v9, v11}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->setContentType(Lcom/rokid/security/sdk/base/common/aichat/AiContentType;)V

    .line 508
    sget-object v11, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    invoke-direct {v11, v9, v2}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendChatContent(Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 509
    nop

    .line 786
    .end local v9    # "it":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .end local v10    # "$i$a$-forEach-GAIChatServiceImpl$handleInspectGuideMessage$1":I
    nop

    .end local v8    # "element$iv":Ljava/lang/Object;
    goto :goto_4

    .line 787
    :cond_7
    nop

    .end local v5    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v6    # "$i$f$forEach":I
    goto :goto_6

    .line 504
    .end local v3    # "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    .end local v4    # "sessionId":Ljava/lang/String;
    :cond_8
    goto :goto_6

    .line 510
    :catch_0
    move-exception v2

    .line 511
    .local v2, "e":Ljava/lang/Exception;
    sget-object v3, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "inspect guide response parse failed type="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 512
    invoke-static {p0, v0, v1, v0}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendError$default(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;ILjava/lang/Object;)V

    .line 514
    .end local v2    # "e":Ljava/lang/Exception;
    :goto_6
    return-void
.end method

.method private final nextMirrorSeq(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "questionId"    # Ljava/lang/String;
    .param p2, "event"    # Ljava/lang/String;

    .line 730
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

    sget-object v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->mirrorSeq:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private final parseJsonOrRaw(Ljava/lang/String;)Ljava/lang/Object;
    .locals 2
    .param p1, "raw"    # Ljava/lang/String;

    .line 473
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 474
    .local v0, "trimmed":Ljava/lang/String;
    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-nez v1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    if-eqz v1, :cond_1

    const-string v1, ""

    return-object v1

    .line 475
    :cond_1
    nop

    .line 476
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 477
    :catch_0
    move-exception v1

    .line 478
    .local v1, "_":Ljava/lang/Exception;
    move-object v1, v0

    .line 475
    .end local v1    # "_":Ljava/lang/Exception;
    :goto_1
    return-object v1
.end method

.method private final resolveChatStreamUrl(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "streamVersion"    # Ljava/lang/String;

    .line 297
    nop

    .line 298
    const-string/jumbo v0, "v3"

    const/4 v1, 0x1

    invoke-static {p1, v0, v1}, Lkotlin/text/StringsKt;->equals(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getAichatV3()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 299
    :cond_0
    const-string/jumbo v0, "v2"

    invoke-static {p1, v0, v1}, Lkotlin/text/StringsKt;->equals(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getAichatV2()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 300
    :cond_1
    sget-object v0, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getAichat()Ljava/lang/String;

    move-result-object v0

    .line 297
    :goto_0
    return-object v0
.end method

.method private final resolveChatStreamVersion(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "requestedVersion"    # Ljava/lang/String;

    .line 289
    nop

    .line 290
    const-string/jumbo v0, "v3"

    const/4 v1, 0x1

    invoke-static {p1, v0, v1}, Lkotlin/text/StringsKt;->equals(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_0

    goto :goto_0

    .line 291
    :cond_0
    const-string/jumbo v0, "v2"

    invoke-static {p1, v0, v1}, Lkotlin/text/StringsKt;->equals(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_1

    goto :goto_0

    .line 292
    :cond_1
    const-string/jumbo v0, "v1"

    .line 289
    :goto_0
    return-object v0
.end method

.method private final sendChatContent(Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V
    .locals 13
    .param p1, "content"    # Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .param p2, "isFinish"    # Z

    .line 600
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "send chat response chars="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/4 v2, 0x0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_0

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    goto :goto_0

    :cond_0
    move v3, v2

    :goto_0
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " finish="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 603
    const-string v0, ""

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_2

    :cond_1
    move-object v1, v0

    .line 604
    .local v1, "answerText":Ljava/lang/String;
    :cond_2
    if-eqz p1, :cond_4

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getSessionId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_4

    invoke-virtual {v3}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    goto :goto_1

    :cond_3
    move-object v0, v3

    .line 606
    .local v0, "currentSessionId":Ljava/lang/String;
    :cond_4
    :goto_1
    sget-object v3, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->GUIDE:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    if-eqz p1, :cond_5

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getContentType()Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    move-result-object v4

    goto :goto_2

    :cond_5
    const/4 v4, 0x0

    :goto_2
    const/4 v5, 0x1

    if-ne v3, v4, :cond_6

    move v3, v5

    goto :goto_3

    :cond_6
    move v3, v2

    .line 612
    .local v3, "isGuide":Z
    :goto_3
    new-instance v4, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v4}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    move-object v6, v4

    .local v6, "$this$sendChatContent_u24lambda_u249":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const/4 v7, 0x0

    .line 613
    .local v7, "$i$a$-apply-GAIChatServiceImpl$sendChatContent$extra$1":I
    const-string v8, "onAiResponse"

    invoke-virtual {v6, v8}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMethodName(Ljava/lang/String;)V

    .line 614
    if-eqz p1, :cond_a

    .line 615
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v8}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setAnswer(Ljava/lang/String;)V

    .line 617
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getSessionId()Ljava/lang/String;

    move-result-object v8

    check-cast v8, Ljava/lang/CharSequence;

    if-eqz v8, :cond_7

    invoke-interface {v8}, Ljava/lang/CharSequence;->length()I

    move-result v8

    if-nez v8, :cond_8

    :cond_7
    move v2, v5

    :cond_8
    if-nez v2, :cond_9

    .line 618
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getSessionId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v6, v2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setSessionId(Ljava/lang/String;)V

    .line 620
    :cond_9
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getContentType()Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    move-result-object v2

    invoke-virtual {v6, v2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setContentType(Lcom/rokid/security/sdk/base/common/aichat/AiContentType;)V

    .line 622
    :cond_a
    invoke-virtual {v6, p2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setAnswerIsFinish(Z)V

    .line 623
    nop

    .line 612
    .end local v6    # "$this$sendChatContent_u24lambda_u249":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v7    # "$i$a$-apply-GAIChatServiceImpl$sendChatContent$extra$1":I
    move-object v2, v4

    .line 624
    .local v2, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    sget-object v4, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v4

    invoke-virtual {v4, v2}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    .line 625
    .local v4, "extraStr":Ljava/lang/String;
    sget-object v5, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    const-string v6, "extraStr"

    invoke-static {v4, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v11, 0x1c

    const/4 v12, 0x0

    const-string v6, "AI_CHAT_API_ACTION"

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    move-object v7, v4

    invoke-static/range {v5 .. v12}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalData$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 626
    return-void
.end method

.method private final sendChatContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;)V
    .locals 13
    .param p1, "question"    # Ljava/lang/String;
    .param p2, "imageUrl"    # Ljava/lang/String;
    .param p3, "questionId"    # Ljava/lang/String;
    .param p4, "content"    # Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .param p5, "isFinish"    # Z
    .param p6, "sessionId"    # Ljava/lang/String;

    .line 525
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "send chat content chars="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/4 v2, 0x0

    if-eqz p4, :cond_0

    invoke-virtual/range {p4 .. p4}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_0

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    goto :goto_0

    :cond_0
    move v3, v2

    :goto_0
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 527
    new-instance v0, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    .line 528
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const-string v1, "onAiResponse"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMethodName(Ljava/lang/String;)V

    .line 529
    if-eqz p4, :cond_1

    .line 530
    invoke-virtual/range {p4 .. p4}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setAnswer(Ljava/lang/String;)V

    .line 531
    invoke-virtual/range {p4 .. p4}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getContentType()Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setContentType(Lcom/rokid/security/sdk/base/common/aichat/AiContentType;)V

    .line 533
    :cond_1
    move-object/from16 v1, p3

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setQuestionId(Ljava/lang/String;)V

    .line 534
    move-object/from16 v3, p6

    invoke-virtual {v0, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setSessionId(Ljava/lang/String;)V

    .line 535
    const-string v4, "glass_wifi_direct"

    invoke-virtual {v0, v4}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setSource(Ljava/lang/String;)V

    .line 536
    if-eqz p4, :cond_3

    invoke-virtual/range {p4 .. p4}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_3

    check-cast v4, Ljava/lang/CharSequence;

    invoke-interface {v4}, Ljava/lang/CharSequence;->length()I

    move-result v4

    const/4 v5, 0x1

    if-lez v4, :cond_2

    move v4, v5

    goto :goto_1

    :cond_2
    move v4, v2

    :goto_1
    if-ne v4, v5, :cond_3

    move v2, v5

    :cond_3
    if-eqz v2, :cond_4

    .line 537
    sget-object v2, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->curAnswerContent:Ljava/lang/StringBuffer;

    invoke-virtual/range {p4 .. p4}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 539
    :cond_4
    nop

    .line 554
    move/from16 v2, p5

    invoke-virtual {v0, v2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setAnswerIsFinish(Z)V

    .line 555
    sget-object v4, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v4

    invoke-virtual {v4, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    .line 556
    .local v4, "extraStr":Ljava/lang/String;
    sget-object v5, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    const-string v6, "extraStr"

    invoke-static {v4, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v11, 0x1c

    const/4 v12, 0x0

    const-string v6, "AI_CHAT_API_ACTION"

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    move-object v7, v4

    invoke-static/range {v5 .. v12}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalData$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 557
    move-object v5, p0

    invoke-direct {p0, v0}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendMirrorResponse(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    .line 558
    return-void
.end method

.method static synthetic sendChatContent$default(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;ILjava/lang/Object;)V
    .locals 9

    .line 517
    and-int/lit8 v0, p7, 0x1

    const-string v1, ""

    if-eqz v0, :cond_0

    .line 518
    move-object v3, v1

    goto :goto_0

    .line 517
    :cond_0
    move-object v3, p1

    :goto_0
    and-int/lit8 v0, p7, 0x2

    if-eqz v0, :cond_1

    .line 519
    move-object v4, v1

    goto :goto_1

    .line 517
    :cond_1
    move-object v4, p2

    :goto_1
    and-int/lit8 v0, p7, 0x20

    if-eqz v0, :cond_3

    .line 523
    if-eqz p4, :cond_2

    invoke-virtual {p4}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getSessionId()Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    :cond_2
    const/4 v0, 0x0

    :goto_2
    move-object v8, v0

    goto :goto_3

    .line 517
    :cond_3
    move-object v8, p6

    :goto_3
    move-object v2, p0

    move-object v5, p3

    move-object v6, p4

    move v7, p5

    invoke-direct/range {v2 .. v8}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendChatContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;)V

    return-void
.end method

.method private final sendChatImgIntent(Ljava/lang/String;Ljava/lang/String;)V
    .locals 10
    .param p1, "intent"    # Ljava/lang/String;
    .param p2, "question"    # Ljava/lang/String;

    .line 654
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "sendChatIntent-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 656
    new-instance v0, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendChatImgIntent_u24lambda_u2412":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const/4 v2, 0x0

    .line 657
    .local v2, "$i$a$-apply-GAIChatServiceImpl$sendChatImgIntent$extra$1":I
    const-string v3, "onAiIntent"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMethodName(Ljava/lang/String;)V

    .line 658
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setIntent(Ljava/lang/String;)V

    .line 659
    invoke-virtual {v1, p2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setQuestion(Ljava/lang/String;)V

    .line 660
    nop

    .line 656
    .end local v1    # "$this$sendChatImgIntent_u24lambda_u2412":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v2    # "$i$a$-apply-GAIChatServiceImpl$sendChatImgIntent$extra$1":I
    nop

    .line 661
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    sget-object v1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 662
    .local v1, "extraStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    const-string v3, "extraStr"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "AI_CHAT_API_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalData$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 663
    return-void
.end method

.method private final sendError(Ljava/lang/String;)V
    .locals 10
    .param p1, "questionId"    # Ljava/lang/String;

    .line 632
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "sendError-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 639
    new-instance v0, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendError_u24lambda_u2411":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const/4 v2, 0x0

    .line 640
    .local v2, "$i$a$-apply-GAIChatServiceImpl$sendError$extra$1":I
    const-string v3, "onError"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMethodName(Ljava/lang/String;)V

    .line 641
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setQuestionId(Ljava/lang/String;)V

    .line 642
    if-eqz p1, :cond_0

    .line 785
    move-object v3, p1

    .local v3, "it":Ljava/lang/String;
    const/4 v4, 0x0

    .line 642
    .local v4, "$i$a$-let-GAIChatServiceImpl$sendError$extra$1$1":I
    sget-object v5, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->questionSessionIds:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v5, v3}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .end local v3    # "it":Ljava/lang/String;
    .end local v4    # "$i$a$-let-GAIChatServiceImpl$sendError$extra$1$1":I
    goto :goto_0

    :cond_0
    const/4 v5, 0x0

    :goto_0
    invoke-virtual {v1, v5}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setSessionId(Ljava/lang/String;)V

    .line 643
    const-string v3, "glass_wifi_direct"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setSource(Ljava/lang/String;)V

    .line 644
    nop

    .line 639
    .end local v1    # "$this$sendError_u24lambda_u2411":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v2    # "$i$a$-apply-GAIChatServiceImpl$sendError$extra$1":I
    nop

    .line 645
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    sget-object v1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 646
    .local v1, "extraStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    const-string v3, "extraStr"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "AI_CHAT_API_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalData$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 647
    invoke-direct {p0, v0}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendMirrorError(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    .line 648
    return-void
.end method

.method static synthetic sendError$default(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;ILjava/lang/Object;)V
    .locals 0

    .line 631
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendError(Ljava/lang/String;)V

    return-void
.end method

.method private final sendMirrorError(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 2
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 716
    const-string v0, "mirrorError"

    invoke-virtual {p1, v0}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMethodName(Ljava/lang/String;)V

    .line 717
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestionId()Ljava/lang/String;

    move-result-object v0

    const-string v1, "error"

    invoke-direct {p0, v0, v1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->nextMirrorSeq(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMirrorSeq(Ljava/lang/String;)V

    .line 718
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendMirrorExtra(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    .line 719
    return-void
.end method

.method private final sendMirrorExtra(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 9
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 722
    sget-object v0, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    .line 723
    nop

    .line 724
    sget-object v1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const-string v1, "SenderHandler.mGson.toJson(extra)"

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 725
    nop

    .line 722
    const/16 v7, 0x38

    const/4 v8, 0x0

    const-string v1, "AI_CHAT_MIRROR_ACTION"

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static/range {v0 .. v8}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalDataByNetworkMode$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 727
    return-void
.end method

.method private final sendMirrorImage(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 8
    .param p1, "questionId"    # Ljava/lang/String;
    .param p2, "requestExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 685
    invoke-virtual {p2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getImageBase64()Ljava/lang/String;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {p2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getImageBase64()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lkotlin/text/StringsKt;->substringAfter(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 686
    .local v0, "imageBase64":Ljava/lang/String;
    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 687
    sget-object v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "mirror image skipped empty payload questionPresent="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object v3, p1

    check-cast v3, Ljava/lang/CharSequence;

    invoke-static {v3}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v3

    xor-int/lit8 v3, v3, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 688
    return-void

    .line 690
    :cond_0
    :try_start_0
    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v1, p0

    check-cast v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    .local v1, "$this$sendMirrorImage_u24lambda_u2414":Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;
    const/4 v2, 0x0

    .line 691
    .local v2, "$i$a$-runCatching-GAIChatServiceImpl$sendMirrorImage$imageBytes$1":I
    const/4 v3, 0x2

    invoke-static {v0, v3}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v3

    .line 690
    .end local v1    # "$this$sendMirrorImage_u24lambda_u2414":Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;
    .end local v2    # "$i$a$-runCatching-GAIChatServiceImpl$sendMirrorImage$imageBytes$1":I
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

    .line 692
    :goto_0
    invoke-static {v1}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v2

    if-nez v2, :cond_1

    check-cast v1, [B

    .line 690
    nop

    .line 696
    .local v1, "imageBytes":[B
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AI_CHAT_MIRROR_IMAGE:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x3a

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->mirrorSeq:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v3}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 697
    .local v2, "streamTag":Ljava/lang/String;
    new-instance v3, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    move-object v4, v3

    .local v4, "$this$sendMirrorImage_u24lambda_u2416":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const/4 v5, 0x0

    .line 698
    .local v5, "$i$a$-apply-GAIChatServiceImpl$sendMirrorImage$extra$1":I
    const-string v6, "mirrorImage"

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMethodName(Ljava/lang/String;)V

    .line 699
    invoke-virtual {v4, p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setQuestionId(Ljava/lang/String;)V

    .line 700
    invoke-virtual {v4, v2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setImageStreamTag(Ljava/lang/String;)V

    .line 701
    invoke-virtual {p2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getAiImageType()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setAiImageType(Ljava/lang/String;)V

    .line 702
    const-string v6, "glass_wifi_direct"

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setSource(Ljava/lang/String;)V

    .line 703
    sget-object v6, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    const-string v7, "image"

    invoke-direct {v6, p1, v7}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->nextMirrorSeq(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMirrorSeq(Ljava/lang/String;)V

    .line 704
    nop

    .line 697
    .end local v4    # "$this$sendMirrorImage_u24lambda_u2416":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v5    # "$i$a$-apply-GAIChatServiceImpl$sendMirrorImage$extra$1":I
    nop

    .line 705
    .local v3, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    invoke-direct {p0, v3}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendMirrorExtra(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    .line 706
    sget-object v4, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    const-string v5, "imageBytes"

    invoke-static {v1, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v5, 0x0

    invoke-virtual {v4, v2, v1, v5}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendStreamDataByNetworkMode(Ljava/lang/String;[BI)V

    .line 707
    return-void

    .line 692
    .end local v1    # "imageBytes":[B
    .end local v2    # "streamTag":Ljava/lang/String;
    .end local v3    # "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    :cond_1
    move-object v1, v2

    .local v1, "it":Ljava/lang/Throwable;
    const/4 v2, 0x0

    .line 693
    .local v2, "$i$a$-getOrElse-GAIChatServiceImpl$sendMirrorImage$imageBytes$2":I
    sget-object v3, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mirror image decode failed type="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 694
    return-void
.end method

.method private final sendMirrorQuestion(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 5
    .param p1, "questionId"    # Ljava/lang/String;
    .param p2, "question"    # Ljava/lang/String;
    .param p3, "imageUrl"    # Ljava/lang/String;
    .param p4, "requestExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 671
    new-instance v0, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendMirrorQuestion_u24lambda_u2413":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const/4 v2, 0x0

    .line 672
    .local v2, "$i$a$-apply-GAIChatServiceImpl$sendMirrorQuestion$extra$1":I
    const-string v3, "mirrorQuestion"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMethodName(Ljava/lang/String;)V

    .line 673
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setQuestionId(Ljava/lang/String;)V

    .line 674
    invoke-virtual {v1, p2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setQuestion(Ljava/lang/String;)V

    .line 675
    if-nez p3, :cond_0

    const-string v3, ""

    goto :goto_0

    :cond_0
    move-object v3, p3

    :goto_0
    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setImageUrl(Ljava/lang/String;)V

    .line 676
    invoke-virtual {p4}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getSessionId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setSessionId(Ljava/lang/String;)V

    .line 677
    invoke-virtual {p4}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getAiImageType()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setAiImageType(Ljava/lang/String;)V

    .line 678
    const-string v3, "glass_wifi_direct"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setSource(Ljava/lang/String;)V

    .line 679
    sget-object v3, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    const-string v4, "question"

    invoke-direct {v3, p1, v4}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->nextMirrorSeq(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMirrorSeq(Ljava/lang/String;)V

    .line 680
    nop

    .line 671
    .end local v1    # "$this$sendMirrorQuestion_u24lambda_u2413":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v2    # "$i$a$-apply-GAIChatServiceImpl$sendMirrorQuestion$extra$1":I
    nop

    .line 681
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    invoke-direct {p0, v0}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendMirrorExtra(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    .line 682
    return-void
.end method

.method private final sendMirrorResponse(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 2
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 710
    const-string v0, "mirrorResponse"

    invoke-virtual {p1, v0}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMethodName(Ljava/lang/String;)V

    .line 711
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestionId()Ljava/lang/String;

    move-result-object v0

    const-string v1, "response"

    invoke-direct {p0, v0, v1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->nextMirrorSeq(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMirrorSeq(Ljava/lang/String;)V

    .line 712
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendMirrorExtra(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    .line 713
    return-void
.end method

.method public static synthetic toAiChat$default(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Lcom/rokid/security/sdk/base/common/AiChatExtra;ZILjava/lang/Object;)V
    .locals 0

    .line 157
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    const/4 p2, 0x0

    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->toAiChat(Lcom/rokid/security/sdk/base/common/AiChatExtra;Z)V

    return-void
.end method


# virtual methods
.method public final getGuideSessionId()Ljava/lang/String;
    .locals 1

    .line 59
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->guideSessionId:Ljava/lang/String;

    return-object v0
.end method

.method public final getMGson()Lcom/google/gson/Gson;
    .locals 1

    .line 63
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->mGson:Lcom/google/gson/Gson;

    return-object v0
.end method

.method public final getMOkHttpSSEClient()Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;
    .locals 1

    .line 64
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    return-object v0
.end method

.method public final initAIChat()V
    .locals 2

    .line 78
    sget-object v0, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageReceiver;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->getMessageAction()Lcom/rokid/security/sdk/ability/message/IMessageAction;

    move-result-object v0

    move-object v1, p0

    check-cast v1, Lcom/rokid/security/sdk/ability/message/ICommonMessage;

    invoke-interface {v0, v1}, Lcom/rokid/security/sdk/ability/message/IMessageAction;->injectIMessage(Lcom/rokid/security/sdk/ability/message/ICommonMessage;)V

    .line 79
    new-instance v0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    .line 80
    return-void
.end method

.method public final isCustom()Z
    .locals 1

    .line 115
    sget-boolean v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->isCustom:Z

    return v0
.end method

.method public onAudioStream([BI)V
    .locals 0
    .param p1, "buffer"    # [B
    .param p2, "type"    # I

    .line 46
    invoke-static {p0, p1, p2}, Lcom/rokid/security/sdk/ability/message/ICommonMessage$DefaultImpls;->onAudioStream(Lcom/rokid/security/sdk/ability/message/ICommonMessage;[BI)V

    return-void
.end method

.method public final onMessage(Ljava/lang/String;)V
    .locals 6
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 121
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "AI_CHAT_API_ACTION"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x2

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {v0, v1, v4, v2, v3}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 122
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "classic-BT message received chars="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 123
    sget-object v0, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    const-class v1, Lcom/rokid/security/sdk/base/common/RkBaseData;

    invoke-virtual {v0, p1, v1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData;

    .line 124
    .local v0, "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    sget-object v1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData;->getExtra()Ljava/lang/String;

    move-result-object v2

    const-class v3, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-virtual {v1, v2, v3}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 126
    .local v1, "mAiChatExtra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "ToInspect"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 129
    sget-object v2, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestion()Ljava/lang/String;

    move-result-object v3

    const-class v5, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-virtual {v2, v3, v5}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 128
    nop

    .line 130
    .local v2, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v3

    const-string v5, "guideAIChatBegin"

    invoke-static {v3, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 131
    sget-object v3, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v5, "\u8fdb\u5165ai\u95ee\u7b54 "

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v3, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 132
    const/4 v3, 0x1

    sput-boolean v3, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->isCustom:Z

    .line 134
    :cond_0
    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v3

    const-string v5, "guideAIChatEnd"

    invoke-static {v3, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 135
    sget-object v3, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v5, "\u9000\u51faai\u95ee\u7b54 "

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v3, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 136
    sput-boolean v4, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->isCustom:Z

    .line 141
    .end local v2    # "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    :cond_1
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    const-string/jumbo v3, "startAiChat"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 143
    sget-object v2, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v3, "\u542f\u52a8AI\u804a\u5929"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 144
    return-void

    .line 146
    :cond_2
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    const-string/jumbo v3, "toAiChat"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 147
    const-string v2, "mAiChatExtra"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-boolean v2, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->isCustom:Z

    invoke-virtual {p0, v1, v2}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->toAiChat(Lcom/rokid/security/sdk/base/common/AiChatExtra;Z)V

    goto :goto_0

    .line 148
    :cond_3
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    const-string/jumbo v3, "stopAiChat"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 149
    sget-object v2, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    if-eqz v2, :cond_4

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->close()V

    .line 155
    .end local v0    # "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    .end local v1    # "mAiChatExtra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    :cond_4
    :goto_0
    return-void
.end method

.method public onMessage(Ljava/lang/String;I)V
    .locals 3
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "type"    # I

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 84
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "message received type="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " chars="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 85
    invoke-virtual {p0, p1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->onMessage(Ljava/lang/String;)V

    .line 86
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

.method public final setCustom(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 115
    sput-boolean p1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->isCustom:Z

    return-void
.end method

.method public final setGuideSessionId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 59
    sput-object p1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->guideSessionId:Ljava/lang/String;

    return-void
.end method

.method public final setMGson(Lcom/google/gson/Gson;)V
    .locals 1
    .param p1, "<set-?>"    # Lcom/google/gson/Gson;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 63
    sput-object p1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->mGson:Lcom/google/gson/Gson;

    return-void
.end method

.method public final setMOkHttpSSEClient(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    .line 64
    sput-object p1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    return-void
.end method

.method public final toAiChat(Lcom/rokid/security/sdk/base/common/AiChatExtra;Z)V
    .locals 25
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .param p2, "isCustom"    # Z

    move-object/from16 v0, p0

    move-object/from16 v9, p1

    const-string v1, "extra"

    invoke-static {v9, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 158
    sget-object v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->curAnswerContent:Ljava/lang/StringBuffer;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 159
    new-instance v1, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v10, v1

    .local v10, "question":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestion()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v10, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 160
    new-instance v1, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v11, v1

    .local v11, "imageUrl":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getImageUrl()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 161
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getImageId()Ljava/lang/String;

    move-result-object v12

    .line 162
    .local v12, "imageId":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getImagePath()Ljava/lang/String;

    move-result-object v13

    .line 163
    .local v13, "imgPath":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getImageBase64()Ljava/lang/String;

    move-result-object v14

    .line 165
    .local v14, "imageBase64":Ljava/lang/String;
    new-instance v1, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v15, v1

    .local v15, "questionId":Lkotlin/jvm/internal/Ref$ObjectRef;
    sget-object v1, Lcom/rokid/security/sdk/ability/asr/AsrManager;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrManager;

    iget-object v3, v10, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->consumeMirrorAsrQuestionId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_0

    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v3, "randomUUID().toString()"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    :cond_0
    iput-object v1, v15, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 166
    new-instance v1, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v8, v1

    .local v8, "aiChatParam":Lkotlin/jvm/internal/Ref$ObjectRef;
    new-instance v1, Lcom/rokid/security/sdk/ability/param/AiChatParam;

    invoke-direct {v1}, Lcom/rokid/security/sdk/ability/param/AiChatParam;-><init>()V

    iput-object v1, v8, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 167
    iget-object v1, v8, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Lcom/rokid/security/sdk/ability/param/AiChatParam;

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    check-cast v3, Ljava/util/List;

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/ability/param/AiChatParam;->setMessages(Ljava/util/List;)V

    .line 169
    new-instance v1, Lcom/rokid/security/sdk/ability/param/AiMessages;

    invoke-direct {v1}, Lcom/rokid/security/sdk/ability/param/AiMessages;-><init>()V

    move-object v7, v1

    .line 170
    .local v7, "mAiMessages":Lcom/rokid/security/sdk/ability/param/AiMessages;
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    check-cast v1, Ljava/util/List;

    invoke-virtual {v7, v1}, Lcom/rokid/security/sdk/ability/param/AiMessages;->setContents(Ljava/util/List;)V

    .line 172
    sget-object v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "toAiChat-->"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, v10, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v4, Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0x20

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v4, Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 173
    new-instance v1, Lcom/rokid/security/sdk/ability/param/AiContent;

    invoke-direct {v1}, Lcom/rokid/security/sdk/ability/param/AiContent;-><init>()V

    move-object v6, v1

    .line 174
    .local v6, "textAiContent":Lcom/rokid/security/sdk/ability/param/AiContent;
    iget-object v1, v10, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    invoke-virtual {v6, v1}, Lcom/rokid/security/sdk/ability/param/AiContent;->setText(Ljava/lang/String;)V

    .line 175
    const-string/jumbo v1, "text"

    invoke-virtual {v6, v1}, Lcom/rokid/security/sdk/ability/param/AiContent;->setType(Ljava/lang/String;)V

    .line 187
    move-object v1, v14

    check-cast v1, Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-lez v1, :cond_1

    const/4 v1, 0x1

    goto :goto_0

    :cond_1
    move v1, v2

    :goto_0
    const-string v4, " imgPath:"

    const-string v5, "imageUrl-->"

    const-string v2, "image/jpeg"

    const-string v3, "image_base64"

    if-eqz v1, :cond_4

    .line 191
    new-instance v1, Lcom/rokid/security/sdk/ability/param/AiContent;

    invoke-direct {v1}, Lcom/rokid/security/sdk/ability/param/AiContent;-><init>()V

    .line 192
    .local v1, "imgAiContent":Lcom/rokid/security/sdk/ability/param/AiContent;
    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/ability/param/AiContent;->setType(Ljava/lang/String;)V

    .line 193
    invoke-virtual {v1, v2}, Lcom/rokid/security/sdk/ability/param/AiContent;->setMimeType(Ljava/lang/String;)V

    .line 194
    invoke-virtual {v1, v14}, Lcom/rokid/security/sdk/ability/param/AiContent;->setData(Ljava/lang/String;)V

    .line 195
    invoke-virtual {v7}, Lcom/rokid/security/sdk/ability/param/AiMessages;->getContents()Ljava/util/List;

    move-result-object v2

    if-eqz v2, :cond_2

    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 196
    :cond_2
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "image-"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v16, v1

    .end local v1    # "imgAiContent":Lcom/rokid/security/sdk/ability/param/AiContent;
    .local v16, "imgAiContent":Lcom/rokid/security/sdk/ability/param/AiContent;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-virtual {v2, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "-aiPic.webp"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 198
    .local v0, "fileName":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getAiImageType()Ljava/lang/String;

    move-result-object v1

    const-string v2, "jpg"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 199
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "-aiPic.jpg"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 202
    :cond_3
    sget-object v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .end local v0    # "fileName":Ljava/lang/String;
    .end local v16    # "imgAiContent":Lcom/rokid/security/sdk/ability/param/AiContent;
    goto/16 :goto_2

    .line 206
    :cond_4
    move-object v0, v13

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-lez v0, :cond_5

    const/16 v16, 0x1

    goto :goto_1

    :cond_5
    const/16 v16, 0x0

    :goto_1
    if-eqz v16, :cond_8

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v13}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_8

    .line 208
    new-instance v0, Lcom/rokid/security/sdk/ability/param/AiContent;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/param/AiContent;-><init>()V

    .line 209
    .local v0, "imgAiContent":Lcom/rokid/security/sdk/ability/param/AiContent;
    invoke-virtual {v0, v3}, Lcom/rokid/security/sdk/ability/param/AiContent;->setType(Ljava/lang/String;)V

    .line 210
    invoke-virtual {v0, v2}, Lcom/rokid/security/sdk/ability/param/AiContent;->setMimeType(Ljava/lang/String;)V

    .line 211
    sget-object v1, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;

    invoke-virtual {v1, v13}, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->fileToBase64(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_6

    const-string v1, ""

    :cond_6
    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/param/AiContent;->setData(Ljava/lang/String;)V

    .line 212
    invoke-virtual {v7}, Lcom/rokid/security/sdk/ability/param/AiMessages;->getContents()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_7

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 214
    :cond_7
    invoke-static {}, Lcom/rokid/security/sdk/ability/util/ContextUtil;->getApplicationContext()Landroid/app/Application;

    move-result-object v1

    check-cast v1, Landroid/content/Context;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/rokid/security/sdk/ability/util/ContextUtil;->getApplicationContext()Landroid/app/Application;

    move-result-object v3

    invoke-virtual {v3}, Landroid/app/Application;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ".fileprovider"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/io/File;

    invoke-direct {v3, v13}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v1, v2, v3}, Landroidx/core/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object v1

    .line 215
    .local v1, "imageNativeUri":Landroid/net/Uri;
    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "imageNativeUri.toString()"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v22, 0x4

    const/16 v23, 0x0

    const-string v19, "content:"

    const-string v20, "https:"

    const/16 v21, 0x0

    move-object/from16 v18, v2

    invoke-static/range {v18 .. v23}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 217
    sget-object v2, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v5, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v5, Ljava/lang/String;

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 222
    .end local v0    # "imgAiContent":Lcom/rokid/security/sdk/ability/param/AiContent;
    .end local v1    # "imageNativeUri":Landroid/net/Uri;
    :cond_8
    :goto_2
    invoke-virtual {v7}, Lcom/rokid/security/sdk/ability/param/AiMessages;->getContents()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_9

    invoke-interface {v0, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 223
    :cond_9
    iget-object v0, v8, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v0, Lcom/rokid/security/sdk/ability/param/AiChatParam;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/param/AiChatParam;->getMessages()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_a

    invoke-interface {v0, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 224
    :cond_a
    iget-object v0, v15, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    iget-object v1, v10, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    iget-object v2, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    move-object/from16 v5, p0

    invoke-direct {v5, v0, v1, v2, v9}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendMirrorQuestion(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    .line 225
    iget-object v0, v15, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    invoke-direct {v5, v0, v9}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendMirrorImage(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    .line 229
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "toAiChat questionChars="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, v10, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " imagePresent="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    const/4 v3, 0x1

    xor-int/2addr v2, v3

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 230
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v16

    new-instance v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;

    const/16 v17, 0x0

    move-object v1, v0

    move-object v2, v15

    move-object v3, v8

    move-object/from16 v4, p1

    move/from16 v5, p2

    move-object/from16 v22, v6

    .end local v6    # "textAiContent":Lcom/rokid/security/sdk/ability/param/AiContent;
    .local v22, "textAiContent":Lcom/rokid/security/sdk/ability/param/AiContent;
    move-object v6, v10

    move-object/from16 v23, v7

    .end local v7    # "mAiMessages":Lcom/rokid/security/sdk/ability/param/AiMessages;
    .local v23, "mAiMessages":Lcom/rokid/security/sdk/ability/param/AiMessages;
    move-object v7, v11

    move-object/from16 v24, v8

    .end local v8    # "aiChatParam":Lkotlin/jvm/internal/Ref$ObjectRef;
    .local v24, "aiChatParam":Lkotlin/jvm/internal/Ref$ObjectRef;
    move-object/from16 v8, v17

    invoke-direct/range {v1 .. v8}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/sdk/base/common/AiChatExtra;ZLkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/coroutines/Continuation;)V

    move-object/from16 v19, v0

    check-cast v19, Lkotlin/jvm/functions/Function2;

    const/16 v20, 0x3

    const/16 v21, 0x0

    const/16 v18, 0x0

    invoke-static/range {v16 .. v21}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 286
    return-void
.end method

.method public final toProductRec(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 13
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    const-string v0, "extra"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 308
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestion()Ljava/lang/String;

    move-result-object v0

    .line 309
    .local v0, "question":Ljava/lang/String;
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getImageUrl()Ljava/lang/String;

    move-result-object v1

    .line 310
    .local v1, "imageUrl":Ljava/lang/String;
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getUseBase64Image()Z

    move-result v2

    .line 316
    .local v2, "useBase64Image":Z
    const/4 v3, 0x2

    new-array v3, v3, [Lkotlin/Pair;

    const-string v4, "promptType"

    const-string v5, "customsGoods"

    invoke-static {v4, v5}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v4

    const/4 v5, 0x0

    aput-object v4, v3, v5

    .line 317
    const-string/jumbo v4, "text"

    invoke-static {v4, v0}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v4

    const/4 v6, 0x1

    aput-object v4, v3, v6

    .line 316
    nop

    .line 315
    invoke-static {v3}, Lkotlin/collections/MapsKt;->mutableMapOf([Lkotlin/Pair;)Ljava/util/Map;

    move-result-object v3

    .line 321
    .local v3, "paramMap":Ljava/util/Map;
    const-string v4, "imageUrl"

    if-eqz v2, :cond_5

    .line 323
    invoke-direct {p0, v1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->convertImageUrlToBase64(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 324
    .local v7, "base64Image":Ljava/lang/String;
    move-object v8, v7

    check-cast v8, Ljava/lang/CharSequence;

    if-eqz v8, :cond_1

    invoke-interface {v8}, Ljava/lang/CharSequence;->length()I

    move-result v8

    if-nez v8, :cond_0

    goto :goto_0

    :cond_0
    move v8, v5

    goto :goto_1

    :cond_1
    :goto_0
    move v8, v6

    :goto_1
    if-nez v8, :cond_2

    .line 325
    const-string v4, "file64"

    invoke-interface {v3, v4, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 326
    sget-object v4, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v9, "toAiChat imageMode=base64 questionChars="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " base64Chars="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    invoke-static {v4, v8}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    goto/16 :goto_4

    .line 329
    :cond_2
    move-object v8, v1

    check-cast v8, Ljava/lang/CharSequence;

    invoke-interface {v8}, Ljava/lang/CharSequence;->length()I

    move-result v8

    if-lez v8, :cond_3

    move v8, v6

    goto :goto_2

    :cond_3
    move v8, v5

    :goto_2
    if-eqz v8, :cond_4

    .line 330
    invoke-interface {v3, v4, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 332
    :cond_4
    sget-object v4, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v9, "toAiChat imageMode=url reason=base64_failed questionChars="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    invoke-static {v4, v8}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .end local v7    # "base64Image":Ljava/lang/String;
    goto :goto_4

    .line 335
    :cond_5
    move-object v7, v1

    check-cast v7, Ljava/lang/CharSequence;

    invoke-interface {v7}, Ljava/lang/CharSequence;->length()I

    move-result v7

    if-lez v7, :cond_6

    move v7, v6

    goto :goto_3

    :cond_6
    move v7, v5

    :goto_3
    if-eqz v7, :cond_7

    .line 336
    invoke-interface {v3, v4, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 338
    :cond_7
    sget-object v4, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v8, "toAiChat imageMode=url questionChars="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " imagePresent="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    move-object v8, v1

    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {v8}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v8

    xor-int/2addr v8, v6

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-static {v4, v7}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 342
    :goto_4
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getSessionId()Ljava/lang/String;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    if-eqz v4, :cond_8

    invoke-interface {v4}, Ljava/lang/CharSequence;->length()I

    move-result v4

    if-nez v4, :cond_9

    :cond_8
    move v5, v6

    :cond_9
    if-nez v5, :cond_a

    .line 343
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getSessionId()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    const-string/jumbo v5, "sessionId"

    invoke-interface {v3, v5, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 346
    :cond_a
    new-instance v4, Lcom/google/gson/Gson;

    invoke-direct {v4}, Lcom/google/gson/Gson;-><init>()V

    invoke-virtual {v4, v3}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    .line 347
    .local v4, "param":Ljava/lang/String;
    sget-object v5, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "onChatAi->  -->"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 349
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v7

    new-instance v5, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;

    const/4 v6, 0x0

    invoke-direct {v5, v4, v6}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;-><init>(Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v10, v5

    check-cast v10, Lkotlin/jvm/functions/Function2;

    const/4 v11, 0x3

    const/4 v12, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    invoke-static/range {v7 .. v12}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 381
    return-void
.end method
