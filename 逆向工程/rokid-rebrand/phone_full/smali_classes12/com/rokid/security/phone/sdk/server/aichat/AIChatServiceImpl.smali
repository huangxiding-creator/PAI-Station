.class public final Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/aichat/api/AbsAIChatService;
.source "AIChatServiceImpl.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nAIChatServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 AIChatServiceImpl.kt\ncom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl\n+ 2 MapsJVM.kt\nkotlin/collections/MapsKt__MapsJVMKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 4 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,1024:1\n73#2,2:1025\n1#3:1027\n1#3:1034\n533#4,6:1028\n1855#4,2:1035\n1855#4,2:1037\n1855#4,2:1039\n766#4:1041\n857#4,2:1042\n*S KotlinDebug\n*F\n+ 1 AIChatServiceImpl.kt\ncom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl\n*L\n223#1:1025,2\n223#1:1027\n273#1:1028,6\n675#1:1035,2\n689#1:1037,2\n755#1:1039,2\n925#1:1041\n925#1:1042,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u00a9\u0001\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0007\n\u0002\u0010!\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010#\n\u0000\n\u0002\u0010\"\n\u0002\u0008\u0007\n\u0002\u0010\u000b\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0008\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u000f\n\u0002\u0010\u0012\n\u0002\u0008\u0008\n\u0002\u0010\u0000\n\u0002\u0008\u0017*\u00019\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0012\u0010K\u001a\u0004\u0018\u00010\u00042\u0006\u0010L\u001a\u00020MH\u0002J\u0012\u0010N\u001a\u0004\u0018\u00010O2\u0006\u0010P\u001a\u00020QH\u0002J\u0012\u0010R\u001a\u0004\u0018\u00010\u00042\u0006\u0010S\u001a\u00020\u0004H\u0002J\u0018\u0010T\u001a\u00020U2\u0006\u0010V\u001a\u00020\u00042\u0006\u0010W\u001a\u00020\u0011H\u0002J\u000e\u0010X\u001a\u0008\u0012\u0004\u0012\u00020\r0\u000cH\u0016J\u0018\u0010Y\u001a\u00020\u00042\u0006\u0010Z\u001a\u00020\u00042\u0006\u0010[\u001a\u00020\u0004H\u0002J\u0015\u0010\\\u001a\u00020U2\u0006\u0010]\u001a\u00020\u0004H\u0000\u00a2\u0006\u0002\u0008^J\u0010\u0010_\u001a\u00020U2\u0006\u0010`\u001a\u00020\u0004H\u0002J0\u0010_\u001a\u00020U2\n\u0008\u0002\u0010]\u001a\u0004\u0018\u00010\u00042\n\u0008\u0002\u0010S\u001a\u0004\u0018\u00010\u00042\u0006\u0010V\u001a\u00020\u00042\u0006\u0010`\u001a\u00020\u0004H\u0002J\u0010\u0010a\u001a\u00020U2\u0006\u0010`\u001a\u00020\u0004H\u0002J\u0018\u0010b\u001a\u00020U2\u0006\u0010c\u001a\u00020\u00042\u0006\u0010d\u001a\u00020eH\u0002J\u0010\u0010f\u001a\u00020U2\u0006\u0010g\u001a\u00020\u0004H\u0002J\u0006\u0010h\u001a\u00020UJ\u0012\u0010i\u001a\u00020!2\u0008\u0010j\u001a\u0004\u0018\u00010\u0004H\u0002J\u0010\u0010k\u001a\u00020!2\u0006\u0010V\u001a\u00020\u0004H\u0002J\u000e\u0010l\u001a\u00020U2\u0006\u0010g\u001a\u00020\u0004J\u0010\u0010m\u001a\u00020n2\u0006\u0010o\u001a\u00020\u0004H\u0002J\u0008\u0010p\u001a\u00020UH\u0016J\u0012\u0010q\u001a\u00020\u00042\u0008\u0010r\u001a\u0004\u0018\u00010\u0004H\u0002J\u0012\u0010s\u001a\u00020\u00042\u0008\u0010t\u001a\u0004\u0018\u00010\u0004H\u0002J\u0010\u0010u\u001a\u00020\u00042\u0006\u0010g\u001a\u00020\u0004H\u0002J\"\u0010v\u001a\u00020\u00042\u0006\u0010d\u001a\u00020e2\u0006\u0010V\u001a\u00020\u00042\u0008\u0010w\u001a\u0004\u0018\u00010\u0004H\u0002J\u001a\u0010x\u001a\u00020U2\u0008\u0010y\u001a\u0004\u0018\u00010O2\u0006\u0010z\u001a\u00020!H\u0002J:\u0010x\u001a\u00020U2\n\u0008\u0002\u0010]\u001a\u0004\u0018\u00010\u00042\n\u0008\u0002\u0010S\u001a\u0004\u0018\u00010\u00042\u0006\u0010V\u001a\u00020\u00042\u0008\u0010y\u001a\u0004\u0018\u00010O2\u0006\u0010z\u001a\u00020!H\u0002J\u0018\u0010{\u001a\u00020U2\u0006\u0010|\u001a\u00020\u00042\u0006\u0010]\u001a\u00020\u0004H\u0002J\u0008\u0010}\u001a\u00020UH\u0002J\u0010\u0010~\u001a\u00020U2\u0006\u0010\u007f\u001a\u00020\'H\u0016J\u0019\u0010\u0080\u0001\u001a\u00020U2\u0006\u0010W\u001a\u00020\u00112\u0008\u0008\u0002\u0010 \u001a\u00020!J\u0011\u0010\u0081\u0001\u001a\u00020U2\u0006\u0010]\u001a\u00020\u0004H\u0016J\u000f\u0010\u0082\u0001\u001a\u00020U2\u0006\u0010W\u001a\u00020\u0011J\u0012\u0010\u0083\u0001\u001a\u00020U2\u0007\u0010\u0084\u0001\u001a\u00020\rH\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u000b\u001a\u0008\u0012\u0004\u0012\u00020\r0\u000cX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000e\u001a\u00020\u000fX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001c\u0010\u0010\u001a\u0004\u0018\u00010\u0011X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0012\u0010\u0013\"\u0004\u0008\u0014\u0010\u0015R2\u0010\u0016\u001a&\u0012\u000c\u0012\n \u0018*\u0004\u0018\u00010\u00040\u0004 \u0018*\u0012\u0012\u000c\u0012\n \u0018*\u0004\u0018\u00010\u00040\u0004\u0018\u00010\u00190\u0017X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u001a\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001b\u0010\u001c\"\u0004\u0008\u001d\u0010\u001eR2\u0010\u001f\u001a&\u0012\u000c\u0012\n \u0018*\u0004\u0018\u00010\u00040\u0004 \u0018*\u0012\u0012\u000c\u0012\n \u0018*\u0004\u0018\u00010\u00040\u0004\u0018\u00010\u00190\u0017X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010 \u001a\u00020!X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008 \u0010\"\"\u0004\u0008#\u0010$R$\u0010%\u001a\u000c\u0012\u0006\u0012\u0004\u0018\u00010\'\u0018\u00010&X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008(\u0010)\"\u0004\u0008*\u0010+R\u001b\u0010,\u001a\u00020-8BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u00080\u00101\u001a\u0004\u0008.\u0010/R\u001a\u00102\u001a\u000203X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u00084\u00105\"\u0004\u00086\u00107R\u0010\u00108\u001a\u000209X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010:R\u001c\u0010;\u001a\u0004\u0018\u00010<X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008=\u0010>\"\u0004\u0008?\u0010@R\u001e\u0010A\u001a\u0012\u0012\u0004\u0012\u00020\u0004\u0012\u0008\u0012\u00060Cj\u0002`D0BX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010E\u001a\u000e\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020\u00040BX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010F\u001a\u000e\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020\u00040BX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010G\u001a\u000e\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020\u00110BX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010H\u001a\u00020!X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008I\u0010\"\"\u0004\u0008J\u0010$\u00a8\u0006\u0085\u0001"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/aichat/api/AbsAIChatService;",
        "()V",
        "ENTRY_MODE_LEGACY_BOOL_PROP",
        "",
        "ENTRY_MODE_PROP",
        "MIRROR_IMAGE_STREAM_PREFIX",
        "MODE_INK_AGENT",
        "PREFS_NAME",
        "PREF_KEY_AI_ENTRY_MODE",
        "TAG",
        "chatList",
        "",
        "Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;",
        "curAnswerContent",
        "Ljava/lang/StringBuffer;",
        "currentAiChatExtra",
        "Lcom/rokid/security/sdk/base/common/AiChatExtra;",
        "getCurrentAiChatExtra",
        "()Lcom/rokid/security/sdk/base/common/AiChatExtra;",
        "setCurrentAiChatExtra",
        "(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V",
        "finishedMirrorQuestions",
        "",
        "kotlin.jvm.PlatformType",
        "",
        "guideSessionId",
        "getGuideSessionId",
        "()Ljava/lang/String;",
        "setGuideSessionId",
        "(Ljava/lang/String;)V",
        "handledMirrorSeqs",
        "isCustom",
        "",
        "()Z",
        "setCustom",
        "(Z)V",
        "mAiChatListener",
        "Ljava/lang/ref/WeakReference;",
        "Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;",
        "getMAiChatListener",
        "()Ljava/lang/ref/WeakReference;",
        "setMAiChatListener",
        "(Ljava/lang/ref/WeakReference;)V",
        "mAiChatRepository",
        "Lcom/rokid/security/phone/sdk/server/aichat/repository/AiChatRepository;",
        "getMAiChatRepository",
        "()Lcom/rokid/security/phone/sdk/server/aichat/repository/AiChatRepository;",
        "mAiChatRepository$delegate",
        "Lkotlin/Lazy;",
        "mGson",
        "Lcom/google/gson/Gson;",
        "getMGson",
        "()Lcom/google/gson/Gson;",
        "setMGson",
        "(Lcom/google/gson/Gson;)V",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$mInterMessageListener$1;",
        "mOkHttpSSEClient",
        "Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;",
        "getMOkHttpSSEClient",
        "()Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;",
        "setMOkHttpSSEClient",
        "(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)V",
        "mirrorAnswerBuffers",
        "Ljava/util/concurrent/ConcurrentHashMap;",
        "Ljava/lang/StringBuilder;",
        "Lkotlin/text/StringBuilder;",
        "mirrorImageTags",
        "mirrorImageUrls",
        "mirrorQuestions",
        "useBase64Image",
        "getUseBase64Image",
        "setUseBase64Image",
        "bitmapToBase64",
        "bitmap",
        "Landroid/graphics/Bitmap;",
        "buildFunctionCallAiContent",
        "Lcom/rokid/security/sdk/base/common/aichat/AiContent;",
        "toolCall",
        "Lcom/rokid/security/sdk/base/common/aichat/ToolCall;",
        "convertImageUrlToBase64",
        "imageUrl",
        "finishMirrorChat",
        "",
        "questionId",
        "extra",
        "getRunTimeChatList",
        "getSystemProperty",
        "key",
        "defaultValue",
        "goIntent",
        "question",
        "goIntent$sdk_server_release",
        "handleAiMessage",
        "message",
        "handleInspectGuideMessage",
        "handleMirrorImageStream",
        "tag",
        "data",
        "",
        "handleMirrorMessage",
        "msg",
        "initAIChat",
        "isDuplicateMirror",
        "seq",
        "markMirrorFinished",
        "onMessage",
        "parseJsonOrRaw",
        "",
        "raw",
        "removeAiChatListener",
        "resolveChatStreamUrl",
        "streamVersion",
        "resolveRequestedChatStreamVersion",
        "requestedVersion",
        "sanitizeLargePayloadLog",
        "saveMirrorImageBytes",
        "imageType",
        "sendChatContent",
        "content",
        "isFinish",
        "sendChatImgIntent",
        "intent",
        "sendError",
        "setAiChatListener",
        "listener",
        "toAiChat",
        "toChat",
        "toProductRec",
        "upsertChatRecord",
        "bean",
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


# static fields
.field private static final ENTRY_MODE_LEGACY_BOOL_PROP:Ljava/lang/String; = "persist.vendor.ink.enable"

.field private static final ENTRY_MODE_PROP:Ljava/lang/String; = "persist.vendor.ai.entry.mode"

.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

.field private static final MIRROR_IMAGE_STREAM_PREFIX:Ljava/lang/String; = "AI_CHAT_MIRROR_IMAGE:"

.field private static final MODE_INK_AGENT:Ljava/lang/String; = "INK_AGENT"

.field private static final PREFS_NAME:Ljava/lang/String; = "app_shared_prefs"

.field private static final PREF_KEY_AI_ENTRY_MODE:Ljava/lang/String; = "AI_CHAT_ENTRY_MODE"

.field private static final TAG:Ljava/lang/String;

.field private static chatList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;",
            ">;"
        }
    .end annotation
.end field

.field private static curAnswerContent:Ljava/lang/StringBuffer;

.field private static currentAiChatExtra:Lcom/rokid/security/sdk/base/common/AiChatExtra;

.field private static final finishedMirrorQuestions:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static guideSessionId:Ljava/lang/String;

.field private static final handledMirrorSeqs:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static isCustom:Z

.field private static mAiChatListener:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;",
            ">;"
        }
    .end annotation
.end field

.field private static final mAiChatRepository$delegate:Lkotlin/Lazy;

.field private static mGson:Lcom/google/gson/Gson;

.field private static final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$mInterMessageListener$1;

.field private static mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

.field private static final mirrorAnswerBuffers:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/StringBuilder;",
            ">;"
        }
    .end annotation
.end field

.field private static final mirrorImageTags:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final mirrorImageUrls:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final mirrorQuestions:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Ljava/lang/String;",
            "Lcom/rokid/security/sdk/base/common/AiChatExtra;",
            ">;"
        }
    .end annotation
.end field

.field private static useBase64Image:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    .line 58
    const-string v0, "AIChatServiceImpl::"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    .line 66
    const/4 v0, 0x1

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->useBase64Image:Z

    .line 71
    const-string v0, "default"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->guideSessionId:Ljava/lang/String;

    .line 75
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mGson:Lcom/google/gson/Gson;

    .line 79
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    check-cast v0, Ljava/util/List;

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->chatList:Ljava/util/List;

    .line 80
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->curAnswerContent:Ljava/lang/StringBuffer;

    .line 81
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    invoke-static {v0}, Ljava/util/Collections;->synchronizedSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->handledMirrorSeqs:Ljava/util/Set;

    .line 82
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    invoke-static {v0}, Ljava/util/Collections;->synchronizedSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    .line 83
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mirrorAnswerBuffers:Ljava/util/concurrent/ConcurrentHashMap;

    .line 84
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mirrorQuestions:Ljava/util/concurrent/ConcurrentHashMap;

    .line 85
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mirrorImageUrls:Ljava/util/concurrent/ConcurrentHashMap;

    .line 86
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mirrorImageTags:Ljava/util/concurrent/ConcurrentHashMap;

    .line 89
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$mAiChatRepository$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$mAiChatRepository$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mAiChatRepository$delegate:Lkotlin/Lazy;

    .line 104
    new-instance v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$mInterMessageListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$mInterMessageListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$mInterMessageListener$1;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 56
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/aichat/api/AbsAIChatService;-><init>()V

    return-void
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 56
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$handleAiMessage(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;
    .param p1, "message"    # Ljava/lang/String;

    .line 56
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->handleAiMessage(Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$handleAiMessage(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;
    .param p1, "question"    # Ljava/lang/String;
    .param p2, "imageUrl"    # Ljava/lang/String;
    .param p3, "questionId"    # Ljava/lang/String;
    .param p4, "message"    # Ljava/lang/String;

    .line 56
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->handleAiMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$handleMirrorImageStream(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;Ljava/lang/String;[B)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B

    .line 56
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->handleMirrorImageStream(Ljava/lang/String;[B)V

    return-void
.end method

.method public static final synthetic access$resolveChatStreamUrl(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;
    .param p1, "streamVersion"    # Ljava/lang/String;

    .line 56
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->resolveChatStreamUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$resolveRequestedChatStreamVersion(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;
    .param p1, "requestedVersion"    # Ljava/lang/String;

    .line 56
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->resolveRequestedChatStreamVersion(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$sendChatContent(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;
    .param p1, "content"    # Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .param p2, "isFinish"    # Z

    .line 56
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->sendChatContent(Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V

    return-void
.end method

.method public static final synthetic access$sendChatContent(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;
    .param p1, "question"    # Ljava/lang/String;
    .param p2, "imageUrl"    # Ljava/lang/String;
    .param p3, "questionId"    # Ljava/lang/String;
    .param p4, "content"    # Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .param p5, "isFinish"    # Z

    .line 56
    invoke-direct/range {p0 .. p5}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->sendChatContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V

    return-void
.end method

.method public static final synthetic access$sendChatImgIntent(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;
    .param p1, "intent"    # Ljava/lang/String;
    .param p2, "question"    # Ljava/lang/String;

    .line 56
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->sendChatImgIntent(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$sendError(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    .line 56
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->sendError()V

    return-void
.end method

.method private final bitmapToBase64(Landroid/graphics/Bitmap;)Ljava/lang/String;
    .locals 4
    .param p1, "bitmap"    # Landroid/graphics/Bitmap;

    .line 1002
    nop

    .line 1003
    :try_start_0
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 1004
    .local v0, "byteArrayOutputStream":Ljava/io/ByteArrayOutputStream;
    sget-object v1, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    move-object v2, v0

    check-cast v2, Ljava/io/OutputStream;

    const/16 v3, 0x50

    invoke-virtual {p1, v1, v3, v2}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 1005
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    .line 1006
    .local v1, "byteArray":[B
    const/4 v2, 0x2

    invoke-static {v1, v2}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "byteArrayOutputStream":Ljava/io/ByteArrayOutputStream;
    .end local v1    # "byteArray":[B
    goto :goto_0

    .line 1007
    :catch_0
    move-exception v0

    .line 1008
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Bitmap\u8f6cbase64\u5931\u8d25: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1009
    const/4 v2, 0x0

    .line 1002
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-object v2
.end method

.method private final buildFunctionCallAiContent(Lcom/rokid/security/sdk/base/common/aichat/ToolCall;)Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .locals 10
    .param p1, "toolCall"    # Lcom/rokid/security/sdk/base/common/aichat/ToolCall;

    .line 697
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->getFunction()Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;

    move-result-object v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    .line 698
    .local v0, "function":Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;
    :cond_0
    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;->getName()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    return-object v1

    .line 699
    :cond_1
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->getExtBody()Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;

    move-result-object v2

    if-eqz v2, :cond_2

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;->getMode()Ljava/lang/String;

    move-result-object v1

    :cond_2
    if-nez v1, :cond_3

    const-string v1, ""

    .line 700
    .local v1, "mode":Ljava/lang/String;
    :cond_3
    const-string v2, "SCENE"

    const/4 v3, 0x1

    invoke-static {v1, v2, v3}, Lkotlin/text/StringsKt;->equals(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v2

    .line 702
    .local v2, "isScene":Z
    sget-object v3, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    .line 703
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "map tool_call id="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->getId()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " type="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->getType()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " function="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " isScene="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " argsLen="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;->getArguments()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    .line 701
    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 705
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    move-object v4, v3

    .local v4, "$this$buildFunctionCallAiContent_u24lambda_u2419":Lorg/json/JSONObject;
    const/4 v5, 0x0

    .line 706
    .local v5, "$i$a$-apply-AIChatServiceImpl$buildFunctionCallAiContent$payload$1":I
    const-string v6, "path"

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v4, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 707
    const-string v6, "aixPath"

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v4, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 709
    sget-object v6, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;->getArguments()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->parseJsonOrRaw(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v6

    const-string v7, "parameters"

    invoke-virtual {v4, v7, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 710
    const-string v6, "isScene"

    invoke-virtual {v4, v6, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 711
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    const-string v7, "mode"

    invoke-virtual {v6, v7, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v6

    const-string v7, "ext_body"

    invoke-virtual {v4, v7, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 712
    const-string/jumbo v6, "tool_call_id"

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->getId()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v4, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 713
    nop

    .line 705
    .end local v4    # "$this$buildFunctionCallAiContent_u24lambda_u2419":Lorg/json/JSONObject;
    .end local v5    # "$i$a$-apply-AIChatServiceImpl$buildFunctionCallAiContent$payload$1":I
    nop

    .line 714
    .local v3, "payload":Lorg/json/JSONObject;
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    move-object v5, v4

    .local v5, "$this$buildFunctionCallAiContent_u24lambda_u2420":Lorg/json/JSONObject;
    const/4 v6, 0x0

    .line 715
    .local v6, "$i$a$-apply-AIChatServiceImpl$buildFunctionCallAiContent$wrapped$1":I
    const-string/jumbo v7, "text"

    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 716
    const-string v7, "contentType"

    const-string v8, "FunctionCall"

    invoke-virtual {v5, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 717
    nop

    .line 714
    .end local v5    # "$this$buildFunctionCallAiContent_u24lambda_u2420":Lorg/json/JSONObject;
    .end local v6    # "$i$a$-apply-AIChatServiceImpl$buildFunctionCallAiContent$wrapped$1":I
    nop

    .line 718
    .local v4, "wrapped":Lorg/json/JSONObject;
    new-instance v5, Lcom/rokid/security/sdk/base/common/aichat/AiContent;

    invoke-direct {v5}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;-><init>()V

    move-object v6, v5

    .local v6, "$this$buildFunctionCallAiContent_u24lambda_u2421":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    const/4 v7, 0x0

    .line 719
    .local v7, "$i$a$-apply-AIChatServiceImpl$buildFunctionCallAiContent$1":I
    invoke-virtual {v4}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v8

    const-string/jumbo v9, "wrapped.toString()"

    invoke-static {v8, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v6, v8}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->setText(Ljava/lang/String;)V

    .line 720
    nop

    .line 718
    .end local v6    # "$this$buildFunctionCallAiContent_u24lambda_u2421":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .end local v7    # "$i$a$-apply-AIChatServiceImpl$buildFunctionCallAiContent$1":I
    return-object v5
.end method

.method private final convertImageUrlToBase64(Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .param p1, "imageUrl"    # Ljava/lang/String;

    .line 966
    nop

    .line 968
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

    .line 987
    :cond_0
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v2, "\u6682\u4e0d\u652f\u6301\u7f51\u7edc\u56fe\u7247URL\u8f6cbase64"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 988
    goto :goto_2

    .line 969
    :cond_1
    :goto_0
    invoke-static {p1, v4, v3, v2, v0}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 970
    const/4 v1, 0x7

    invoke-virtual {p1, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v4, "this as java.lang.String).substring(startIndex)"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    goto :goto_1

    .line 972
    :cond_2
    move-object v1, p1

    .line 969
    :goto_1
    nop

    .line 977
    .local v1, "filePath":Ljava/lang/String;
    new-instance v4, Ljava/io/File;

    invoke-direct {v4, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 978
    .local v4, "file":Ljava/io/File;
    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_3

    .line 980
    invoke-static {v4}, Lkotlin/io/FilesKt;->readBytes(Ljava/io/File;)[B

    move-result-object v3

    .line 981
    .local v3, "fileBytes":[B
    invoke-static {v3, v2}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v0

    .end local v3    # "fileBytes":[B
    goto :goto_2

    .line 983
    :cond_3
    sget-object v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

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

    .line 984
    nop

    .line 988
    .end local v1    # "filePath":Ljava/lang/String;
    .end local v4    # "file":Ljava/io/File;
    :goto_2
    goto :goto_3

    .line 990
    :catch_0
    move-exception v1

    .line 991
    .local v1, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u56fe\u7247\u8f6cbase64\u5931\u8d25: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 992
    nop

    .line 966
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_3
    return-object v0
.end method

.method private final finishMirrorChat(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 9
    .param p1, "questionId"    # Ljava/lang/String;
    .param p2, "extra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 351
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mirrorQuestions:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 352
    .local v0, "question":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mirrorAnswerBuffers:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v1, p1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/StringBuilder;

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v2

    :goto_0
    const-string v3, ""

    if-nez v1, :cond_1

    move-object v1, v3

    .line 353
    .local v1, "answer":Ljava/lang/String;
    :cond_1
    sget-object v4, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mirrorImageUrls:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v4, p1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    if-nez v4, :cond_2

    move-object v4, v3

    :cond_2
    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_5

    const/4 v4, 0x0

    .line 354
    .local v4, "$i$a$-ifBlank-AIChatServiceImpl$finishMirrorChat$imageUrl$1":I
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getImageUrl()Ljava/lang/String;

    move-result-object v5

    goto :goto_1

    :cond_3
    move-object v5, v2

    :goto_1
    if-nez v5, :cond_4

    move-object v5, v3

    .line 353
    .end local v4    # "$i$a$-ifBlank-AIChatServiceImpl$finishMirrorChat$imageUrl$1":I
    :cond_4
    move-object v4, v5

    :cond_5
    check-cast v4, Ljava/lang/String;

    .line 356
    .local v4, "imageUrl":Ljava/lang/String;
    if-nez v0, :cond_7

    move-object v5, v1

    check-cast v5, Ljava/lang/CharSequence;

    invoke-interface {v5}, Ljava/lang/CharSequence;->length()I

    move-result v5

    if-lez v5, :cond_6

    const/4 v5, 0x1

    goto :goto_2

    :cond_6
    const/4 v5, 0x0

    :goto_2
    if-eqz v5, :cond_a

    .line 357
    :cond_7
    sget-object v5, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->chatList:Ljava/util/List;

    new-instance v6, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;

    invoke-direct {v6}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;-><init>()V

    move-object v7, v6

    .local v7, "$this$finishMirrorChat_u24lambda_u2414":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    const/4 v8, 0x0

    .line 358
    .local v8, "$i$a$-apply-AIChatServiceImpl$finishMirrorChat$1":I
    invoke-virtual {v7, p1}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setQuestionId(Ljava/lang/String;)V

    .line 359
    if-eqz v0, :cond_8

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestion()Ljava/lang/String;

    move-result-object v2

    :cond_8
    if-nez v2, :cond_9

    goto :goto_3

    :cond_9
    move-object v3, v2

    :goto_3
    invoke-virtual {v7, v3}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setQuestion(Ljava/lang/String;)V

    .line 360
    invoke-virtual {v7, v1}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setAnswer(Ljava/lang/String;)V

    .line 361
    invoke-virtual {v7, v4}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setImageUrl(Ljava/lang/String;)V

    .line 362
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v7, v2, v3}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setTime(J)V

    .line 363
    nop

    .line 357
    .end local v7    # "$this$finishMirrorChat_u24lambda_u2414":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    .end local v8    # "$i$a$-apply-AIChatServiceImpl$finishMirrorChat$1":I
    invoke-interface {v5, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 365
    :cond_a
    return-void
.end method

.method private final getMAiChatRepository()Lcom/rokid/security/phone/sdk/server/aichat/repository/AiChatRepository;
    .locals 1

    .line 89
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mAiChatRepository$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/aichat/repository/AiChatRepository;

    return-object v0
.end method

.method private final getSystemProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "defaultValue"    # Ljava/lang/String;

    .line 538
    nop

    .line 539
    :try_start_0
    const-string v0, "android.os.SystemProperties"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 540
    .local v0, "clazz":Ljava/lang/Class;
    const-string v1, "get"

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Class;

    const-class v3, Ljava/lang/String;

    const/4 v4, 0x0

    aput-object v3, v2, v4

    const-class v3, Ljava/lang/String;

    const/4 v4, 0x1

    aput-object v3, v2, v4

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 541
    .local v1, "method":Ljava/lang/reflect/Method;
    filled-new-array {p1, p2}, [Ljava/lang/Object;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v1, v3, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    instance-of v4, v2, Ljava/lang/String;

    if-eqz v4, :cond_0

    move-object v3, v2

    check-cast v3, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    if-nez v3, :cond_1

    move-object v3, p2

    goto :goto_0

    .line 542
    .end local v0    # "clazz":Ljava/lang/Class;
    .end local v1    # "method":Ljava/lang/reflect/Method;
    :catch_0
    move-exception v0

    .line 543
    .local v0, "_":Ljava/lang/Exception;
    move-object v3, p2

    .line 538
    .end local v0    # "_":Ljava/lang/Exception;
    :cond_1
    :goto_0
    return-object v3
.end method

.method private final handleAiMessage(Ljava/lang/String;)V
    .locals 7
    .param p1, "message"    # Ljava/lang/String;

    .line 804
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

    .line 805
    return-void

    .line 808
    :cond_1
    nop

    .line 810
    :try_start_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mGson:Lcom/google/gson/Gson;

    const-class v2, Lcom/rokid/security/phone/sdk/server/aichat/data/ProductIdentifyResponse;

    invoke-virtual {v0, p1, v2}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    const-string v2, "mGson.fromJson(message, \u2026tifyResponse::class.java)"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Lcom/rokid/security/phone/sdk/server/aichat/data/ProductIdentifyResponse;

    .line 811
    .local v0, "productResponse":Lcom/rokid/security/phone/sdk/server/aichat/data/ProductIdentifyResponse;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "handleAiMessage--> \u5546\u54c1\u8bc6\u522b\u7ed3\u679c: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/aichat/data/ProductIdentifyResponse;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", \u54c1\u724c: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/aichat/data/ProductIdentifyResponse;->getBrand()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", \u4ef7\u683c: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/aichat/data/ProductIdentifyResponse;->getPrice()D

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/aichat/data/ProductIdentifyResponse;->getUnit()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 814
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u8bc6\u522b\u7ed3\u679c\uff1a\n\u5546\u54c1\u540d\u79f0\uff1a"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 815
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/aichat/data/ProductIdentifyResponse;->getName()Ljava/lang/String;

    move-result-object v3

    .line 814
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 815
    const-string v3, "\n\u54c1\u724c\uff1a"

    .line 814
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 816
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/aichat/data/ProductIdentifyResponse;->getBrand()Ljava/lang/String;

    move-result-object v3

    .line 814
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 816
    const-string v3, "\n\u5206\u7c7b\uff1a"

    .line 814
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 817
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/aichat/data/ProductIdentifyResponse;->getItemCategory()Ljava/lang/String;

    move-result-object v3

    .line 814
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 817
    const-string v3, " - "

    .line 814
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 817
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/aichat/data/ProductIdentifyResponse;->getSubItemCategory()Ljava/lang/String;

    move-result-object v3

    .line 814
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 817
    const-string v3, "\n\u4ef7\u683c\uff1a"

    .line 814
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 818
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/aichat/data/ProductIdentifyResponse;->getPrice()D

    move-result-wide v3

    .line 814
    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x20

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 818
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/aichat/data/ProductIdentifyResponse;->getUnit()Ljava/lang/String;

    move-result-object v3

    .line 814
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 818
    const-string v3, "\n\u89c4\u683c\uff1a"

    .line 814
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 819
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/aichat/data/ProductIdentifyResponse;->getSpecifications()Ljava/lang/String;

    move-result-object v3

    .line 814
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 819
    const-string v3, "\n\u6761\u5f62\u7801\uff1a"

    .line 814
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 820
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/aichat/data/ProductIdentifyResponse;->getBarcode()Ljava/lang/String;

    move-result-object v3

    .line 814
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 823
    .local v2, "responseText":Ljava/lang/String;
    new-instance v3, Lcom/rokid/security/sdk/base/common/aichat/AiContent;

    invoke-direct {v3}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;-><init>()V

    move-object v4, v3

    .local v4, "$this$handleAiMessage_u24lambda_u2423":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    const/4 v5, 0x0

    .line 824
    .local v5, "$i$a$-apply-AIChatServiceImpl$handleAiMessage$aiContent$1":I
    invoke-virtual {v4, v2}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->setText(Ljava/lang/String;)V

    .line 826
    sget-object v6, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->guideSessionId:Ljava/lang/String;

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->setSessionId(Ljava/lang/String;)V

    .line 827
    nop

    .line 823
    .end local v4    # "$this$handleAiMessage_u24lambda_u2423":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .end local v5    # "$i$a$-apply-AIChatServiceImpl$handleAiMessage$aiContent$1":I
    nop

    .line 828
    .local v3, "aiContent":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    invoke-direct {p0, v3, v1}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->sendChatContent(Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "productResponse":Lcom/rokid/security/phone/sdk/server/aichat/data/ProductIdentifyResponse;
    .end local v2    # "responseText":Ljava/lang/String;
    .end local v3    # "aiContent":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    goto :goto_1

    .line 830
    :catch_0
    move-exception v0

    .line 831
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u89e3\u6790\u5546\u54c1\u8bc6\u522b\u54cd\u5e94\u5931\u8d25: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2, v0}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 832
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->sendError()V

    .line 834
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method private final handleAiMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 19
    .param p1, "question"    # Ljava/lang/String;
    .param p2, "imageUrl"    # Ljava/lang/String;
    .param p3, "questionId"    # Ljava/lang/String;
    .param p4, "message"    # Ljava/lang/String;

    .line 659
    move-object/from16 v0, p4

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

    .line 660
    return-void

    .line 662
    :cond_1
    new-instance v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$handleAiMessage$type$1;

    invoke-direct {v1}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$handleAiMessage$type$1;-><init>()V

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$handleAiMessage$type$1;->getType()Ljava/lang/reflect/Type;

    move-result-object v1

    .line 663
    .local v1, "type":Ljava/lang/reflect/Type;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mGson:Lcom/google/gson/Gson;

    invoke-virtual {v4, v0, v1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/reflect/Type;)Ljava/lang/Object;

    move-result-object v4

    const-string v5, "mGson.fromJson(message, type)"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v4, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;

    .line 664
    .local v4, "aiResponse":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    sget-object v5, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

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

    const/4 v8, 0x0

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
    move-object v7, v8

    :goto_1
    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 665
    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getCode()Ljava/lang/Integer;

    move-result-object v5

    if-nez v5, :cond_3

    move-object/from16 v13, p3

    goto/16 :goto_6

    :cond_3
    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    if-nez v5, :cond_e

    .line 666
    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v5, :cond_4

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getMessage()Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

    move-result-object v5

    if-eqz v5, :cond_4

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->getToolCalls()Ljava/util/List;

    move-result-object v5

    if-eqz v5, :cond_4

    check-cast v5, Ljava/util/Collection;

    invoke-interface {v5}, Ljava/util/Collection;->isEmpty()Z

    move-result v5

    xor-int/2addr v5, v2

    if-ne v5, v2, :cond_4

    goto :goto_2

    :cond_4
    move v2, v3

    .line 667
    .local v2, "hasToolCalls":Z
    :goto_2
    if-eqz v2, :cond_8

    .line 668
    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v5, :cond_5

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getOutputMetadata()Lcom/rokid/security/sdk/base/common/aichat/OutputMetadata;

    move-result-object v5

    if-eqz v5, :cond_5

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/aichat/OutputMetadata;->getFinishReason()Ljava/lang/String;

    move-result-object v8

    :cond_5
    if-nez v8, :cond_6

    const-string v8, ""

    :cond_6
    move-object v5, v8

    .line 670
    .local v5, "finishReason":Ljava/lang/String;
    sget-object v6, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    .line 671
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v8, "v2 tool_calls received count="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v8, :cond_7

    invoke-virtual {v8}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getMessage()Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

    move-result-object v8

    if-eqz v8, :cond_7

    invoke-virtual {v8}, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->getToolCalls()Ljava/util/List;

    move-result-object v8

    if-eqz v8, :cond_7

    invoke-interface {v8}, Ljava/util/List;->size()I

    move-result v3

    :cond_7
    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v7, " finishReason="

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v7, " questionId="

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v13, p3

    invoke-virtual {v3, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    .line 669
    invoke-static {v6, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_3

    .line 667
    .end local v5    # "finishReason":Ljava/lang/String;
    :cond_8
    move-object/from16 v13, p3

    .line 674
    :goto_3
    if-eqz v2, :cond_b

    .line 675
    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v3, :cond_b

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getMessage()Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

    move-result-object v3

    if-eqz v3, :cond_b

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->getToolCalls()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_b

    check-cast v3, Ljava/lang/Iterable;

    .local v3, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v5, 0x0

    .line 1035
    .local v5, "$i$f$forEach":I
    invoke-interface {v3}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_4
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_a

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v14

    .local v14, "element$iv":Ljava/lang/Object;
    move-object v15, v14

    check-cast v15, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;

    .local v15, "toolCall":Lcom/rokid/security/sdk/base/common/aichat/ToolCall;
    const/16 v16, 0x0

    .line 676
    .local v16, "$i$a$-forEach-AIChatServiceImpl$handleAiMessage$1":I
    sget-object v7, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    invoke-direct {v7, v15}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->buildFunctionCallAiContent(Lcom/rokid/security/sdk/base/common/aichat/ToolCall;)Lcom/rokid/security/sdk/base/common/aichat/AiContent;

    move-result-object v17

    .line 677
    .local v17, "functionCallContent":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    if-eqz v17, :cond_9

    .line 678
    sget-object v7, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    .line 679
    nop

    .line 680
    nop

    .line 681
    nop

    .line 682
    nop

    .line 683
    nop

    .line 678
    const/4 v12, 0x0

    move-object/from16 v8, p1

    move-object/from16 v9, p2

    move-object/from16 v10, p3

    move-object/from16 v11, v17

    invoke-direct/range {v7 .. v12}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->sendChatContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V

    .line 686
    :cond_9
    nop

    .line 1035
    .end local v15    # "toolCall":Lcom/rokid/security/sdk/base/common/aichat/ToolCall;
    .end local v16    # "$i$a$-forEach-AIChatServiceImpl$handleAiMessage$1":I
    .end local v17    # "functionCallContent":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    nop

    .end local v14    # "element$iv":Ljava/lang/Object;
    goto :goto_4

    .line 1036
    :cond_a
    nop

    .line 688
    .end local v3    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v5    # "$i$f$forEach":I
    :cond_b
    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v3, :cond_d

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getMessage()Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

    move-result-object v3

    if-eqz v3, :cond_d

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->getContents()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_d

    .local v3, "contents":Ljava/util/List;
    const/4 v5, 0x0

    .line 689
    .local v5, "$i$a$-let-AIChatServiceImpl$handleAiMessage$2":I
    move-object v6, v3

    check-cast v6, Ljava/lang/Iterable;

    .local v6, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v14, 0x0

    .line 1037
    .local v14, "$i$f$forEach":I
    invoke-interface {v6}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v15

    :goto_5
    invoke-interface {v15}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_c

    invoke-interface {v15}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v16

    .local v16, "element$iv":Ljava/lang/Object;
    move-object/from16 v17, v16

    check-cast v17, Lcom/rokid/security/sdk/base/common/aichat/AiContent;

    .local v17, "it":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    const/16 v18, 0x0

    .line 690
    .local v18, "$i$a$-forEach-AIChatServiceImpl$handleAiMessage$2$1":I
    sget-object v7, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    const/4 v12, 0x0

    move-object/from16 v8, p1

    move-object/from16 v9, p2

    move-object/from16 v10, p3

    move-object/from16 v11, v17

    invoke-direct/range {v7 .. v12}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->sendChatContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V

    .line 691
    nop

    .line 1037
    .end local v17    # "it":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .end local v18    # "$i$a$-forEach-AIChatServiceImpl$handleAiMessage$2$1":I
    nop

    .end local v16    # "element$iv":Ljava/lang/Object;
    goto :goto_5

    .line 1038
    :cond_c
    nop

    .line 692
    .end local v6    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v14    # "$i$f$forEach":I
    nop

    .line 688
    .end local v3    # "contents":Ljava/util/List;
    .end local v5    # "$i$a$-let-AIChatServiceImpl$handleAiMessage$2":I
    :cond_d
    goto :goto_6

    .line 665
    .end local v2    # "hasToolCalls":Z
    :cond_e
    move-object/from16 v13, p3

    .line 694
    :goto_6
    return-void
.end method

.method static synthetic handleAiMessage$default(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    .locals 1

    .line 658
    and-int/lit8 p6, p5, 0x1

    const-string v0, ""

    if-eqz p6, :cond_0

    move-object p1, v0

    :cond_0
    and-int/lit8 p5, p5, 0x2

    if-eqz p5, :cond_1

    move-object p2, v0

    :cond_1
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->handleAiMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private final handleInspectGuideMessage(Ljava/lang/String;)V
    .locals 12
    .param p1, "message"    # Ljava/lang/String;

    .line 737
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

    .line 738
    return-void

    .line 741
    :cond_1
    nop

    .line 742
    :try_start_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "handleInspectMessage--> \u5de1\u67e5guide\u7ed3\u679c: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 746
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mGson:Lcom/google/gson/Gson;

    new-instance v3, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$handleInspectGuideMessage$response$1;

    invoke-direct {v3}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$handleInspectGuideMessage$response$1;-><init>()V

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$handleInspectGuideMessage$response$1;->getType()Ljava/lang/reflect/Type;

    move-result-object v3

    invoke-virtual {v0, p1, v3}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/reflect/Type;)Ljava/lang/Object;

    move-result-object v0

    const-string v3, "mGson.fromJson(message, \u20263<AIResponse>>() {}.type)"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;

    .line 745
    nop

    .line 747
    .local v0, "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v3, :cond_2

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getSessionId()Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    :cond_2
    const/4 v3, 0x0

    .line 750
    .local v3, "sessionId":Ljava/lang/String;
    :goto_1
    move-object v4, v3

    check-cast v4, Ljava/lang/CharSequence;

    if-eqz v4, :cond_4

    invoke-interface {v4}, Ljava/lang/CharSequence;->length()I

    move-result v4

    if-nez v4, :cond_3

    goto :goto_2

    :cond_3
    move v1, v2

    :cond_4
    :goto_2
    if-nez v1, :cond_5

    const-string v1, "default"

    invoke-static {v3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    .line 751
    sput-object v3, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->guideSessionId:Ljava/lang/String;

    .line 752
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "\u66f4\u65b0audioSessionId: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->guideSessionId:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v1, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 755
    :cond_5
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v1, :cond_7

    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getMessage()Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

    move-result-object v1

    if-eqz v1, :cond_7

    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->getContents()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_7

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v4, 0x0

    .line 1039
    .local v4, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_3
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_6

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    .local v6, "element$iv":Ljava/lang/Object;
    move-object v7, v6

    check-cast v7, Lcom/rokid/security/sdk/base/common/aichat/AiContent;

    .local v7, "it":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    const/4 v8, 0x0

    .line 756
    .local v8, "$i$a$-forEach-AIChatServiceImpl$handleInspectGuideMessage$1":I
    sget-object v9, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "handleInspectMessage--> \u5de1\u68c0guide\u5185\u5bb9: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v7}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    filled-new-array {v10}, [Ljava/lang/Object;

    move-result-object v10

    invoke-static {v9, v10}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 757
    sget-object v9, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->guideSessionId:Ljava/lang/String;

    invoke-virtual {v7, v9}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->setSessionId(Ljava/lang/String;)V

    .line 758
    sget-object v9, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->GUIDE:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    invoke-virtual {v7, v9}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->setContentType(Lcom/rokid/security/sdk/base/common/aichat/AiContentType;)V

    .line 759
    sget-object v9, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    invoke-direct {v9, v7, v2}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->sendChatContent(Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 760
    nop

    .line 1039
    .end local v7    # "it":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .end local v8    # "$i$a$-forEach-AIChatServiceImpl$handleInspectGuideMessage$1":I
    nop

    .end local v6    # "element$iv":Ljava/lang/Object;
    goto :goto_3

    .line 1040
    :cond_6
    nop

    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v4    # "$i$f$forEach":I
    goto :goto_4

    .line 755
    .end local v0    # "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    .end local v3    # "sessionId":Ljava/lang/String;
    :cond_7
    goto :goto_4

    .line 761
    :catch_0
    move-exception v0

    .line 762
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u89e3\u6790\u5de1\u68c0guide\u54cd\u5e94\u5931\u8d25: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2, v0}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 763
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->sendError()V

    .line 765
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_4
    return-void
.end method

.method private final handleMirrorImageStream(Ljava/lang/String;[B)V
    .locals 13
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B

    .line 257
    const-string v0, "AI_CHAT_MIRROR_IMAGE:"

    const/4 v1, 0x0

    const/4 v2, 0x2

    const/4 v3, 0x0

    invoke-static {p1, v0, v1, v2, v3}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    return-void

    .line 258
    :cond_0
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mirrorImageTags:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v1, p1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    if-nez v1, :cond_1

    .line 259
    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {p1, v0}, Lkotlin/text/StringsKt;->removePrefix(Ljava/lang/String;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v1, ":"

    invoke-static {v0, v1, v3, v2, v3}, Lkotlin/text/StringsKt;->substringBefore$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 258
    :cond_1
    const-string v0, "mirrorImageTags.remove(t\u2026FIX).substringBefore(\":\")"

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v0, v1

    .line 260
    .local v0, "questionId":Ljava/lang/String;
    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 261
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "handleMirrorImageStream ignored empty questionId tag="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 262
    return-void

    .line 264
    :cond_2
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mirrorQuestions:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v1, v0}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 265
    .local v1, "question":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    if-eqz v1, :cond_3

    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getAiImageType()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_3
    move-object v2, v3

    :goto_0
    invoke-direct {p0, p2, v0, v2}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->saveMirrorImageBytes([BLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 266
    .local v2, "imageUrl":Ljava/lang/String;
    move-object v4, v2

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_4

    return-void

    .line 268
    :cond_4
    sget-object v4, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mirrorImageUrls:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v4, Ljava/util/Map;

    invoke-interface {v4, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 269
    if-nez v1, :cond_5

    goto :goto_1

    :cond_5
    invoke-virtual {v1, v2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setImageUrl(Ljava/lang/String;)V

    .line 271
    :goto_1
    const/4 v4, 0x0

    .local v4, "questionText":Ljava/lang/Object;
    if-eqz v1, :cond_6

    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestion()Ljava/lang/String;

    move-result-object v5

    goto :goto_2

    :cond_6
    move-object v5, v3

    :goto_2
    const-string v6, ""

    if-nez v5, :cond_7

    move-object v5, v6

    :cond_7
    move-object v4, v5

    .line 272
    if-nez v1, :cond_b

    .line 273
    sget-object v5, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->chatList:Ljava/util/List;

    .local v5, "$this$lastOrNull$iv":Ljava/util/List;
    const/4 v7, 0x0

    .line 1028
    .local v7, "$i$f$lastOrNull":I
    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v8

    invoke-interface {v5, v8}, Ljava/util/List;->listIterator(I)Ljava/util/ListIterator;

    move-result-object v8

    .line 1029
    .local v8, "iterator$iv":Ljava/util/ListIterator;
    :cond_8
    invoke-interface {v8}, Ljava/util/ListIterator;->hasPrevious()Z

    move-result v9

    if-eqz v9, :cond_9

    .line 1030
    invoke-interface {v8}, Ljava/util/ListIterator;->previous()Ljava/lang/Object;

    move-result-object v9

    .line 1031
    .local v9, "element$iv":Ljava/lang/Object;
    move-object v10, v9

    check-cast v10, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;

    .local v10, "it":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    const/4 v11, 0x0

    .line 273
    .local v11, "$i$a$-lastOrNull-AIChatServiceImpl$handleMirrorImageStream$1":I
    invoke-virtual {v10}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->getQuestionId()Ljava/lang/String;

    move-result-object v12

    invoke-static {v12, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v10

    .line 1031
    .end local v10    # "it":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    .end local v11    # "$i$a$-lastOrNull-AIChatServiceImpl$handleMirrorImageStream$1":I
    if-eqz v10, :cond_8

    move-object v3, v9

    goto :goto_3

    .line 1033
    .end local v9    # "element$iv":Ljava/lang/Object;
    :cond_9
    nop

    .line 273
    .end local v5    # "$this$lastOrNull$iv":Ljava/util/List;
    .end local v7    # "$i$f$lastOrNull":I
    .end local v8    # "iterator$iv":Ljava/util/ListIterator;
    :goto_3
    check-cast v3, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;

    if-eqz v3, :cond_b

    .local v3, "chat":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    const/4 v5, 0x0

    .line 274
    .local v5, "$i$a$-let-AIChatServiceImpl$handleMirrorImageStream$2":I
    invoke-virtual {v3, v2}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setImageUrl(Ljava/lang/String;)V

    .line 275
    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->getQuestion()Ljava/lang/String;

    move-result-object v7

    if-nez v7, :cond_a

    goto :goto_4

    :cond_a
    move-object v6, v7

    :goto_4
    move-object v4, v6

    .line 276
    nop

    .line 273
    .end local v3    # "chat":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    .end local v5    # "$i$a$-let-AIChatServiceImpl$handleMirrorImageStream$2":I
    nop

    .line 278
    :cond_b
    sget-object v3, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mAiChatListener:Ljava/lang/ref/WeakReference;

    if-eqz v3, :cond_c

    invoke-virtual {v3}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    if-eqz v3, :cond_c

    invoke-interface {v3, v0, v4, v2}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onAIChatQuestion(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 280
    :cond_c
    if-nez v1, :cond_d

    sget-object v3, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    invoke-interface {v3, v0}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_d

    .line 281
    sget-object v3, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mirrorImageUrls:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v3, v0}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 283
    :cond_d
    return-void
.end method

.method private final handleMirrorMessage(Ljava/lang/String;)V
    .locals 12
    .param p1, "msg"    # Ljava/lang/String;

    .line 180
    :try_start_0
    sget-object v0, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v0, p0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    .local v0, "$this$handleMirrorMessage_u24lambda_u242":Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;
    const/4 v1, 0x0

    .line 181
    .local v1, "$i$a$-runCatching-AIChatServiceImpl$handleMirrorMessage$1":I
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    const-class v3, Lcom/rokid/security/sdk/base/common/RkBaseData;

    invoke-virtual {v2, p1, v3}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/rokid/security/sdk/base/common/RkBaseData;

    .line 182
    .local v2, "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v3

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/RkBaseData;->getExtra()Ljava/lang/String;

    move-result-object v4

    const-class v5, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-virtual {v3, v4, v5}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 183
    .local v3, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMirrorSeq()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v0, v4}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->isDuplicateMirror(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 184
    sget-object v4, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "handleMirrorMessage duplicate seq="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMirrorSeq()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 185
    return-void

    .line 187
    :cond_0
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestionId()Ljava/lang/String;

    move-result-object v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const-string v5, ""

    if-nez v4, :cond_1

    :try_start_1
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getSessionId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_1

    move-object v4, v5

    .line 188
    .local v4, "questionId":Ljava/lang/String;
    :cond_1
    move-object v6, v4

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v6}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 189
    sget-object v5, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "handleMirrorMessage ignored empty questionId, method="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 190
    return-void

    .line 193
    :cond_2
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/String;->hashCode()I

    move-result v7
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const-string v8, "extra"

    const/4 v9, 0x1

    sparse-switch v7, :sswitch_data_0

    :goto_0
    goto/16 :goto_5

    :sswitch_0
    :try_start_2
    const-string v5, "mirrorAsrPartial"

    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_10

    goto :goto_0

    :sswitch_1
    const-string v7, "mirrorQuestion"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_3

    goto :goto_0

    .line 195
    :cond_3
    sget-object v6, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    invoke-interface {v6, v4}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 196
    sget-object v6, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mirrorQuestions:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v6, Ljava/util/Map;

    invoke-static {v3, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v6, v4, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 197
    sget-object v6, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mirrorAnswerBuffers:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v6, Ljava/util/Map;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {v6, v4, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 198
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getImageUrl()Ljava/lang/String;

    move-result-object v6

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v6}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_5

    const/4 v6, 0x0

    .line 199
    .local v6, "$i$a$-ifBlank-AIChatServiceImpl$handleMirrorMessage$1$imageUrl$1":I
    sget-object v7, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mirrorImageUrls:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v7, v4}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    if-nez v7, :cond_4

    goto :goto_1

    :cond_4
    move-object v5, v7

    .line 198
    .end local v6    # "$i$a$-ifBlank-AIChatServiceImpl$handleMirrorMessage$1$imageUrl$1":I
    :goto_1
    move-object v6, v5

    :cond_5
    check-cast v6, Ljava/lang/String;

    move-object v5, v6

    .line 201
    .local v5, "imageUrl":Ljava/lang/String;
    move-object v6, v5

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v6}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v6

    xor-int/2addr v6, v9

    if-eqz v6, :cond_6

    .line 202
    invoke-virtual {v3, v5}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setImageUrl(Ljava/lang/String;)V

    .line 203
    sget-object v6, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mirrorImageUrls:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v6, Ljava/util/Map;

    invoke-interface {v6, v4, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 205
    :cond_6
    sget-object v6, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mAiChatListener:Ljava/lang/ref/WeakReference;

    if-eqz v6, :cond_14

    invoke-virtual {v6}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    if-eqz v6, :cond_14

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestion()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v6, v4, v7, v5}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onAIChatQuestion(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_6

    .line 193
    .end local v5    # "imageUrl":Ljava/lang/String;
    :sswitch_2
    const-string v5, "mirrorResponse"

    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_7

    goto :goto_0

    .line 221
    :cond_7
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getAnswer()Ljava/lang/String;

    move-result-object v5

    .line 222
    .local v5, "answer":Ljava/lang/String;
    move-object v6, v5

    check-cast v6, Ljava/lang/CharSequence;

    invoke-interface {v6}, Ljava/lang/CharSequence;->length()I

    move-result v6

    if-lez v6, :cond_8

    goto :goto_2

    :cond_8
    const/4 v9, 0x0

    :goto_2
    if-eqz v9, :cond_b

    .line 223
    sget-object v6, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mirrorAnswerBuffers:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v6, Ljava/util/concurrent/ConcurrentMap;

    .local v6, "$this$getOrPut$iv":Ljava/util/concurrent/ConcurrentMap;
    const/4 v7, 0x0

    .line 1025
    .local v7, "$i$f$getOrPut":I
    invoke-interface {v6, v4}, Ljava/util/concurrent/ConcurrentMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    if-nez v9, :cond_a

    .line 1026
    const/4 v9, 0x0

    .line 223
    .local v9, "$i$a$-getOrPut-AIChatServiceImpl$handleMirrorMessage$1$1":I
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    .line 1026
    .end local v9    # "$i$a$-getOrPut-AIChatServiceImpl$handleMirrorMessage$1$1":I
    move-object v9, v10

    .line 1027
    .local v9, "default$iv":Ljava/lang/Object;
    const/4 v10, 0x0

    .line 1026
    .local v10, "$i$a$-let-MapsKt__MapsJVMKt$getOrPut$1$iv":I
    invoke-interface {v6, v4, v9}, Ljava/util/concurrent/ConcurrentMap;->putIfAbsent(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11

    if-nez v11, :cond_9

    goto :goto_3

    :cond_9
    move-object v9, v11

    .line 1025
    .end local v9    # "default$iv":Ljava/lang/Object;
    .end local v10    # "$i$a$-let-MapsKt__MapsJVMKt$getOrPut$1$iv":I
    :cond_a
    :goto_3
    nop

    .end local v6    # "$this$getOrPut$iv":Ljava/util/concurrent/ConcurrentMap;
    .end local v7    # "$i$f$getOrPut":I
    check-cast v9, Ljava/lang/StringBuilder;

    .line 223
    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 225
    :cond_b
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getAnswerIsFinish()Z

    move-result v6

    if-eqz v6, :cond_c

    invoke-direct {v0, v4}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->markMirrorFinished(Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_c

    .line 226
    sget-object v6, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "handleMirrorMessage ignored duplicate finish, questionId="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-static {v6, v7}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 227
    return-void

    .line 229
    :cond_c
    sget-object v6, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mAiChatListener:Ljava/lang/ref/WeakReference;

    if-eqz v6, :cond_d

    invoke-virtual {v6}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    if-eqz v6, :cond_d

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getAnswerIsFinish()Z

    move-result v7

    invoke-interface {v6, v4, v5, v7}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onAiChatAnswer(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 230
    :cond_d
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getAnswerIsFinish()Z

    move-result v6

    if-eqz v6, :cond_14

    .line 231
    invoke-static {v3, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {v0, v4, v3}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->finishMirrorChat(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    .end local v5    # "answer":Ljava/lang/String;
    goto/16 :goto_6

    .line 193
    :sswitch_3
    const-string v7, "mirrorImage"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_e

    goto/16 :goto_0

    .line 214
    :cond_e
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getImageStreamTag()Ljava/lang/String;

    move-result-object v6

    if-nez v6, :cond_f

    goto :goto_4

    :cond_f
    move-object v5, v6

    .line 215
    .local v5, "streamTag":Ljava/lang/String;
    :goto_4
    move-object v6, v5

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v6}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v6

    xor-int/2addr v6, v9

    if-eqz v6, :cond_14

    .line 216
    sget-object v6, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mirrorImageTags:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v6, Ljava/util/Map;

    invoke-interface {v6, v5, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_6

    .line 193
    .end local v5    # "streamTag":Ljava/lang/String;
    :sswitch_4
    const-string v5, "mirrorAsrFinal"

    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_10

    goto/16 :goto_0

    .line 210
    :cond_10
    sget-object v5, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mAiChatListener:Ljava/lang/ref/WeakReference;

    if-eqz v5, :cond_14

    invoke-virtual {v5}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    if-eqz v5, :cond_14

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestion()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getImageUrl()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v5, v4, v6, v7}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onAIChatQuestion(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_6

    .line 193
    :sswitch_5
    const-string v5, "mirrorError"

    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_11

    goto/16 :goto_0

    .line 236
    :cond_11
    invoke-direct {v0, v4}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->markMirrorFinished(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_12

    .line 237
    sget-object v5, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "handleMirrorMessage ignored duplicate error, questionId="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 238
    return-void

    .line 240
    :cond_12
    sget-object v5, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mAiChatListener:Ljava/lang/ref/WeakReference;

    if-eqz v5, :cond_13

    invoke-virtual {v5}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    if-eqz v5, :cond_13

    .line 241
    nop

    .line 242
    const-string v6, "AI\u8bc6\u522b\u670d\u52a1\u51fa\u73b0\u9519\u8bef\uff0c\u8bf7\u7a0d\u540e\u518d\u8bd5"

    .line 243
    nop

    .line 240
    invoke-interface {v5, v4, v6, v9}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onAiChatAnswer(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 245
    :cond_13
    invoke-static {v3, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {v0, v4, v3}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->finishMirrorChat(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    goto :goto_6

    .line 248
    :goto_5
    sget-object v5, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "handleMirrorMessage ignored method="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 250
    :cond_14
    :goto_6
    nop

    .line 251
    nop

    .end local v0    # "$this$handleMirrorMessage_u24lambda_u242":Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;
    .end local v1    # "$i$a$-runCatching-AIChatServiceImpl$handleMirrorMessage$1":I
    .end local v2    # "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    .end local v3    # "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v4    # "questionId":Ljava/lang/String;
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 180
    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_7

    :catchall_0
    move-exception v0

    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v0}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 251
    :goto_7
    invoke-static {v0}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v0

    if-eqz v0, :cond_15

    .local v0, "it":Ljava/lang/Throwable;
    const/4 v1, 0x0

    .line 252
    .local v1, "$i$a$-onFailure-AIChatServiceImpl$handleMirrorMessage$2":I
    sget-object v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "handleMirrorMessage failed: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3, v0}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 253
    nop

    .line 251
    .end local v0    # "it":Ljava/lang/Throwable;
    .end local v1    # "$i$a$-onFailure-AIChatServiceImpl$handleMirrorMessage$2":I
    nop

    .line 254
    :cond_15
    return-void

    :sswitch_data_0
    .sparse-switch
        -0x69630a77 -> :sswitch_5
        -0x6961784b -> :sswitch_4
        -0x692d3324 -> :sswitch_3
        -0x63fd4ae0 -> :sswitch_2
        0x6acddcc5 -> :sswitch_1
        0x6cb3fc00 -> :sswitch_0
    .end sparse-switch
.end method

.method private final isDuplicateMirror(Ljava/lang/String;)Z
    .locals 9
    .param p1, "seq"    # Ljava/lang/String;

    .line 316
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_1

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    move v0, v2

    goto :goto_1

    :cond_1
    :goto_0
    move v0, v1

    :goto_1
    if-eqz v0, :cond_2

    return v2

    .line 317
    :cond_2
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->handledMirrorSeqs:Ljava/util/Set;

    const-string v3, "handledMirrorSeqs"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    monitor-enter v0

    const/4 v3, 0x0

    .line 318
    .local v3, "$i$a$-synchronized-AIChatServiceImpl$isDuplicateMirror$1":I
    :try_start_0
    sget-object v4, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->handledMirrorSeqs:Ljava/util/Set;

    invoke-interface {v4, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v4, :cond_3

    .end local v3    # "$i$a$-synchronized-AIChatServiceImpl$isDuplicateMirror$1":I
    monitor-exit v0

    return v1

    .line 319
    .restart local v3    # "$i$a$-synchronized-AIChatServiceImpl$isDuplicateMirror$1":I
    :cond_3
    :try_start_1
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->handledMirrorSeqs:Ljava/util/Set;

    invoke-interface {v1, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 320
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->handledMirrorSeqs:Ljava/util/Set;

    invoke-interface {v1}, Ljava/util/Set;->size()I

    move-result v1

    const/16 v4, 0x12c

    if-le v1, v4, :cond_5

    .line 321
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->handledMirrorSeqs:Ljava/util/Set;

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .line 322
    .local v1, "iterator":Ljava/util/Iterator;
    sget-object v5, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->handledMirrorSeqs:Ljava/util/Set;

    invoke-interface {v5}, Ljava/util/Set;->size()I

    move-result v5

    sub-int/2addr v5, v4

    move v4, v2

    :goto_2
    if-ge v4, v5, :cond_5

    move v6, v4

    .local v6, "it":I
    const/4 v7, 0x0

    .line 323
    .local v7, "$i$a$-repeat-AIChatServiceImpl$isDuplicateMirror$1$1":I
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_4

    .line 324
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 325
    invoke-interface {v1}, Ljava/util/Iterator;->remove()V

    .line 327
    :cond_4
    nop

    .line 322
    .end local v6    # "it":I
    .end local v7    # "$i$a$-repeat-AIChatServiceImpl$isDuplicateMirror$1$1":I
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 329
    .end local v1    # "iterator":Ljava/util/Iterator;
    :cond_5
    nop

    .end local v3    # "$i$a$-synchronized-AIChatServiceImpl$isDuplicateMirror$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 317
    monitor-exit v0

    .line 330
    return v2

    .line 317
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private final markMirrorFinished(Ljava/lang/String;)Z
    .locals 8
    .param p1, "questionId"    # Ljava/lang/String;

    .line 334
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    const-string v1, "finishedMirrorQuestions"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    monitor-enter v0

    const/4 v1, 0x0

    .line 335
    .local v1, "$i$a$-synchronized-AIChatServiceImpl$markMirrorFinished$1":I
    :try_start_0
    sget-object v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    invoke-interface {v2, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v3, 0x0

    if-eqz v2, :cond_0

    .end local v1    # "$i$a$-synchronized-AIChatServiceImpl$markMirrorFinished$1":I
    monitor-exit v0

    return v3

    .line 336
    .restart local v1    # "$i$a$-synchronized-AIChatServiceImpl$markMirrorFinished$1":I
    :cond_0
    :try_start_1
    sget-object v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    invoke-interface {v2, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 337
    sget-object v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    invoke-interface {v2}, Ljava/util/Set;->size()I

    move-result v2

    const/16 v4, 0x64

    if-le v2, v4, :cond_2

    .line 338
    sget-object v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .line 339
    .local v2, "iterator":Ljava/util/Iterator;
    sget-object v5, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    invoke-interface {v5}, Ljava/util/Set;->size()I

    move-result v5

    sub-int/2addr v5, v4

    :goto_0
    if-ge v3, v5, :cond_2

    move v4, v3

    .local v4, "it":I
    const/4 v6, 0x0

    .line 340
    .local v6, "$i$a$-repeat-AIChatServiceImpl$markMirrorFinished$1$1":I
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_1

    .line 341
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 342
    invoke-interface {v2}, Ljava/util/Iterator;->remove()V

    .line 344
    :cond_1
    nop

    .line 339
    .end local v4    # "it":I
    .end local v6    # "$i$a$-repeat-AIChatServiceImpl$markMirrorFinished$1$1":I
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 346
    .end local v2    # "iterator":Ljava/util/Iterator;
    :cond_2
    nop

    .end local v1    # "$i$a$-synchronized-AIChatServiceImpl$markMirrorFinished$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 334
    monitor-exit v0

    .line 347
    const/4 v0, 0x1

    return v0

    .line 334
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private final parseJsonOrRaw(Ljava/lang/String;)Ljava/lang/Object;
    .locals 2
    .param p1, "raw"    # Ljava/lang/String;

    .line 724
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 725
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

    .line 726
    :cond_1
    nop

    .line 727
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 728
    :catch_0
    move-exception v1

    .line 729
    .local v1, "_":Ljava/lang/Exception;
    move-object v1, v0

    .line 726
    .end local v1    # "_":Ljava/lang/Exception;
    :goto_1
    return-object v1
.end method

.method private final resolveChatStreamUrl(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "streamVersion"    # Ljava/lang/String;

    .line 530
    const-string/jumbo v0, "v2"

    const/4 v1, 0x1

    invoke-static {p1, v0, v1}, Lkotlin/text/StringsKt;->equals(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 531
    sget-object v0, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getAichatV2()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 533
    :cond_0
    sget-object v0, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getAichat()Ljava/lang/String;

    move-result-object v0

    .line 530
    :goto_0
    return-object v0
.end method

.method private final resolveRequestedChatStreamVersion(Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .param p1, "requestedVersion"    # Ljava/lang/String;

    .line 502
    const-string/jumbo v0, "v2"

    const/4 v1, 0x1

    invoke-static {p1, v0, v1}, Lkotlin/text/StringsKt;->equals(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_0

    return-object v0

    .line 503
    :cond_0
    const-string/jumbo v2, "v1"

    invoke-static {p1, v2, v1}, Lkotlin/text/StringsKt;->equals(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v3

    if-eqz v3, :cond_1

    return-object v2

    .line 508
    :cond_1
    nop

    .line 505
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v3

    .line 506
    const-string v4, "app_shared_prefs"

    const/4 v5, 0x0

    invoke-virtual {v3, v4, v5}, Landroid/app/Application;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 507
    const-string v4, "AI_CHAT_ENTRY_MODE"

    const-string v5, ""

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    move-object v3, v5

    .line 508
    :cond_2
    nop

    .line 505
    nop

    .line 509
    .local v3, "entryModeFromSp":Ljava/lang/String;
    const-string v4, "INK_AGENT"

    invoke-static {v3, v4, v1}, Lkotlin/text/StringsKt;->equals(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v6

    const/16 v7, 0x29

    const-string v8, " request="

    if-eqz v6, :cond_3

    .line 510
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "resolveRequestedChatStreamVersion -> v2 (source=sp mode="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 511
    return-object v0

    .line 514
    :cond_3
    const-string v6, "persist.vendor.ai.entry.mode"

    invoke-direct {p0, v6, v5}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->getSystemProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 515
    .local v5, "entryMode":Ljava/lang/String;
    invoke-static {v5, v4, v1}, Lkotlin/text/StringsKt;->equals(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 516
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "resolveRequestedChatStreamVersion -> v2 (source=prop mode="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 517
    return-object v0

    .line 520
    :cond_4
    const-string v1, "persist.vendor.ink.enable"

    const-string v4, "0"

    invoke-direct {p0, v1, v4}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->getSystemProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 521
    .local v1, "legacyFlag":Ljava/lang/String;
    const-string v4, "1"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    goto :goto_0

    :cond_5
    move-object v0, v2

    .line 523
    .local v0, "version":Ljava/lang/String;
    :goto_0
    sget-object v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    .line 524
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "resolveRequestedChatStreamVersion -> "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " (source=legacy legacyFlag="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " spMode="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " propMode="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    .line 522
    invoke-static {v2, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 526
    return-object v0
.end method

.method private final sanitizeLargePayloadLog(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p1, "msg"    # Ljava/lang/String;

    .line 1014
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

    .line 1015
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    move-object v4, v2

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v0, v4, v3}, Lkotlin/text/StringsKt;->contains(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1016
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v4, 0x400

    if-gt v0, v4, :cond_0

    .line 1018
    return-object p1

    .line 1020
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

.method private final saveMirrorImageBytes([BLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 16
    .param p1, "data"    # [B
    .param p2, "questionId"    # Ljava/lang/String;
    .param p3, "imageType"    # Ljava/lang/String;

    .line 290
    move-object/from16 v1, p1

    array-length v0, v1

    const/4 v2, 0x1

    if-nez v0, :cond_0

    move v0, v2

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    const-string v3, ""

    if-eqz v0, :cond_1

    return-object v3

    .line 291
    :cond_1
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v0

    const-string v4, "receiver"

    invoke-virtual {v0, v4}, Landroid/app/Application;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    if-nez v0, :cond_2

    return-object v3

    :cond_2
    move-object v4, v0

    .line 292
    .local v4, "appPrivateDir":Ljava/io/File;
    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_3

    invoke-virtual {v4}, Ljava/io/File;->mkdirs()Z

    move-result v0

    if-nez v0, :cond_3

    .line 293
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v2, "saveMirrorImageBytes failed to create receiver directory"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 294
    return-object v3

    .line 296
    :cond_3
    const-string/jumbo v0, "webp"

    move-object/from16 v5, p3

    invoke-static {v5, v0, v2}, Lkotlin/text/StringsKt;->equals(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_4

    goto :goto_1

    :cond_4
    const-string v0, "jpg"

    :goto_1
    move-object v2, v0

    .line 297
    .local v2, "extension":Ljava/lang/String;
    new-instance v0, Ljava/io/File;

    .line 298
    nop

    .line 299
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "image-"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    invoke-virtual {v6, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    const/16 v7, 0x2d

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v6

    move-object/from16 v7, p2

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v8, "-aiPic."

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 297
    invoke-direct {v0, v4, v6}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    move-object v6, v0

    .line 301
    .local v6, "outputFile":Ljava/io/File;
    :try_start_0
    sget-object v0, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object/from16 v0, p0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    move-object v8, v0

    .local v8, "$this$saveMirrorImageBytes_u24lambda_u247":Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;
    const/4 v9, 0x0

    .local v9, "$i$a$-runCatching-AIChatServiceImpl$saveMirrorImageBytes$1":I
    new-instance v0, Ljava/io/FileOutputStream;

    .line 302
    invoke-direct {v0, v6}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    move-object v10, v0

    check-cast v10, Ljava/io/Closeable;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    :try_start_1
    move-object v0, v10

    check-cast v0, Ljava/io/FileOutputStream;

    .line 1034
    .local v0, "it":Ljava/io/FileOutputStream;
    const/4 v11, 0x0

    .line 302
    .local v11, "$i$a$-use-AIChatServiceImpl$saveMirrorImageBytes$1$1":I
    invoke-virtual {v0, v1}, Ljava/io/FileOutputStream;->write([B)V

    .end local v0    # "it":Ljava/io/FileOutputStream;
    .end local v11    # "$i$a$-use-AIChatServiceImpl$saveMirrorImageBytes$1$1":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const/4 v0, 0x0

    :try_start_2
    invoke-static {v10, v0}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 304
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v0

    check-cast v0, Landroid/content/Context;

    .line 305
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v11

    invoke-virtual {v11}, Landroid/app/Application;->getPackageName()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ".fileprovider"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    .line 306
    nop

    .line 303
    invoke-static {v0, v10, v6}, Landroidx/core/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object v0

    .line 308
    .local v0, "imageNativeUri":Landroid/net/Uri;
    invoke-virtual {v0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v10

    const-string v11, "imageNativeUri.toString()"

    invoke-static {v10, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v11, "content:"

    const-string v12, "https:"

    const/4 v14, 0x4

    const/4 v15, 0x0

    const/4 v13, 0x0

    invoke-static/range {v10 .. v15}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v10

    .line 301
    .end local v0    # "imageNativeUri":Landroid/net/Uri;
    .end local v8    # "$this$saveMirrorImageBytes_u24lambda_u247":Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;
    .end local v9    # "$i$a$-runCatching-AIChatServiceImpl$saveMirrorImageBytes$1":I
    invoke-static {v10}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    goto :goto_2

    .line 302
    .restart local v8    # "$this$saveMirrorImageBytes_u24lambda_u247":Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;
    .restart local v9    # "$i$a$-runCatching-AIChatServiceImpl$saveMirrorImageBytes$1":I
    :catchall_0
    move-exception v0

    move-object v11, v0

    .end local v2    # "extension":Ljava/lang/String;
    .end local v4    # "appPrivateDir":Ljava/io/File;
    .end local v6    # "outputFile":Ljava/io/File;
    .end local v8    # "$this$saveMirrorImageBytes_u24lambda_u247":Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;
    .end local v9    # "$i$a$-runCatching-AIChatServiceImpl$saveMirrorImageBytes$1":I
    .end local p1    # "data":[B
    .end local p2    # "questionId":Ljava/lang/String;
    .end local p3    # "imageType":Ljava/lang/String;
    :try_start_3
    throw v11
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .restart local v2    # "extension":Ljava/lang/String;
    .restart local v4    # "appPrivateDir":Ljava/io/File;
    .restart local v6    # "outputFile":Ljava/io/File;
    .restart local v8    # "$this$saveMirrorImageBytes_u24lambda_u247":Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;
    .restart local v9    # "$i$a$-runCatching-AIChatServiceImpl$saveMirrorImageBytes$1":I
    .restart local p1    # "data":[B
    .restart local p2    # "questionId":Ljava/lang/String;
    .restart local p3    # "imageType":Ljava/lang/String;
    :catchall_1
    move-exception v0

    move-object v12, v0

    :try_start_4
    invoke-static {v10, v11}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v2    # "extension":Ljava/lang/String;
    .end local v4    # "appPrivateDir":Ljava/io/File;
    .end local v6    # "outputFile":Ljava/io/File;
    .end local p1    # "data":[B
    .end local p2    # "questionId":Ljava/lang/String;
    .end local p3    # "imageType":Ljava/lang/String;
    throw v12
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 301
    .end local v8    # "$this$saveMirrorImageBytes_u24lambda_u247":Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;
    .end local v9    # "$i$a$-runCatching-AIChatServiceImpl$saveMirrorImageBytes$1":I
    .restart local v2    # "extension":Ljava/lang/String;
    .restart local v4    # "appPrivateDir":Ljava/io/File;
    .restart local v6    # "outputFile":Ljava/io/File;
    .restart local p1    # "data":[B
    .restart local p2    # "questionId":Ljava/lang/String;
    .restart local p3    # "imageType":Ljava/lang/String;
    :catchall_2
    move-exception v0

    sget-object v8, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v0}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 309
    :goto_2
    invoke-static {v0}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v8

    if-nez v8, :cond_5

    move-object v3, v0

    goto :goto_3

    :cond_5
    move-object v0, v8

    .local v0, "it":Ljava/lang/Throwable;
    const/4 v8, 0x0

    .line 310
    .local v8, "$i$a$-getOrElse-AIChatServiceImpl$saveMirrorImageBytes$2":I
    sget-object v9, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v11, "saveMirrorImageBytes failed: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    filled-new-array {v10, v0}, [Ljava/lang/Object;

    move-result-object v10

    invoke-static {v9, v10}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 311
    nop

    .line 309
    .end local v0    # "it":Ljava/lang/Throwable;
    .end local v8    # "$i$a$-getOrElse-AIChatServiceImpl$saveMirrorImageBytes$2":I
    :goto_3
    check-cast v3, Ljava/lang/String;

    .line 301
    return-object v3
.end method

.method private final sendChatContent(Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V
    .locals 13
    .param p1, "content"    # Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .param p2, "isFinish"    # Z

    .line 840
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "sendChatContent-->"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/4 v2, 0x0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    :cond_0
    move-object v3, v2

    :goto_0
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " isFinish:"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 843
    const-string v0, ""

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_2

    :cond_1
    move-object v1, v0

    .line 844
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

    .line 846
    .local v0, "currentSessionId":Ljava/lang/String;
    :cond_4
    :goto_1
    sget-object v3, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->GUIDE:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    if-eqz p1, :cond_5

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getContentType()Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    move-result-object v4

    goto :goto_2

    :cond_5
    move-object v4, v2

    :goto_2
    const/4 v5, 0x1

    const/4 v6, 0x0

    if-ne v3, v4, :cond_6

    move v3, v5

    goto :goto_3

    :cond_6
    move v3, v6

    .line 847
    .local v3, "isGuide":Z
    :goto_3
    if-nez v3, :cond_8

    .line 848
    sget-object v4, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mAiChatListener:Ljava/lang/ref/WeakReference;

    if-eqz v4, :cond_7

    invoke-virtual {v4}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    .line 849
    .local v2, "aiChatListener":Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;
    :cond_7
    if-eqz v2, :cond_8

    invoke-interface {v2, v0, v1, p2}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onAiChatAnswer(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 852
    .end local v2    # "aiChatListener":Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;
    :cond_8
    new-instance v2, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    move-object v4, v2

    .local v4, "$this$sendChatContent_u24lambda_u2424":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const/4 v7, 0x0

    .line 853
    .local v7, "$i$a$-apply-AIChatServiceImpl$sendChatContent$extra$1":I
    const-string v8, "onAiResponse"

    invoke-virtual {v4, v8}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMethodName(Ljava/lang/String;)V

    .line 854
    if-eqz p1, :cond_c

    .line 855
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v4, v8}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setAnswer(Ljava/lang/String;)V

    .line 857
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getSessionId()Ljava/lang/String;

    move-result-object v8

    check-cast v8, Ljava/lang/CharSequence;

    if-eqz v8, :cond_a

    invoke-interface {v8}, Ljava/lang/CharSequence;->length()I

    move-result v8

    if-nez v8, :cond_9

    goto :goto_4

    :cond_9
    move v5, v6

    :cond_a
    :goto_4
    if-nez v5, :cond_b

    .line 858
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getSessionId()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setSessionId(Ljava/lang/String;)V

    .line 860
    :cond_b
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getContentType()Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setContentType(Lcom/rokid/security/sdk/base/common/aichat/AiContentType;)V

    .line 862
    :cond_c
    invoke-virtual {v4, p2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setAnswerIsFinish(Z)V

    .line 863
    nop

    .line 852
    .end local v4    # "$this$sendChatContent_u24lambda_u2424":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v7    # "$i$a$-apply-AIChatServiceImpl$sendChatContent$extra$1":I
    nop

    .line 864
    .local v2, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v4

    invoke-virtual {v4, v2}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    .line 865
    .local v4, "extraStr":Ljava/lang/String;
    sget-object v5, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v6, "extraStr"

    invoke-static {v4, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v11, 0x1c

    const/4 v12, 0x0

    const-string v6, "AI_CHAT_API_ACTION"

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    move-object v7, v4

    invoke-static/range {v5 .. v12}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 866
    return-void
.end method

.method private final sendChatContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V
    .locals 16
    .param p1, "question"    # Ljava/lang/String;
    .param p2, "imageUrl"    # Ljava/lang/String;
    .param p3, "questionId"    # Ljava/lang/String;
    .param p4, "content"    # Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .param p5, "isFinish"    # Z

    .line 769
    move-object/from16 v0, p3

    move/from16 v1, p5

    sget-object v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "sendChatIntent-->"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/4 v4, 0x0

    if-eqz p4, :cond_0

    invoke-virtual/range {p4 .. p4}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v5

    goto :goto_0

    :cond_0
    move-object v5, v4

    :goto_0
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 771
    new-instance v2, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    .line 772
    .local v2, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const-string v3, "onAiResponse"

    invoke-virtual {v2, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMethodName(Ljava/lang/String;)V

    .line 773
    if-eqz p4, :cond_1

    .line 774
    invoke-virtual/range {p4 .. p4}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setAnswer(Ljava/lang/String;)V

    .line 775
    invoke-virtual/range {p4 .. p4}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getContentType()Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setContentType(Lcom/rokid/security/sdk/base/common/aichat/AiContentType;)V

    .line 777
    :cond_1
    const/4 v3, 0x0

    if-eqz p4, :cond_3

    invoke-virtual/range {p4 .. p4}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_3

    check-cast v5, Ljava/lang/CharSequence;

    invoke-interface {v5}, Ljava/lang/CharSequence;->length()I

    move-result v5

    const/4 v6, 0x1

    if-lez v5, :cond_2

    move v5, v6

    goto :goto_1

    :cond_2
    move v5, v3

    :goto_1
    if-ne v5, v6, :cond_3

    move v3, v6

    :cond_3
    if-eqz v3, :cond_4

    .line 778
    sget-object v3, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->curAnswerContent:Ljava/lang/StringBuffer;

    invoke-virtual/range {p4 .. p4}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 780
    :cond_4
    if-eqz v1, :cond_5

    .line 781
    new-instance v3, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;

    invoke-direct {v3}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;-><init>()V

    .line 782
    .local v3, "bean":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    invoke-virtual {v3, v0}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setQuestionId(Ljava/lang/String;)V

    .line 783
    move-object/from16 v5, p1

    invoke-virtual {v3, v5}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setQuestion(Ljava/lang/String;)V

    .line 784
    sget-object v6, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->curAnswerContent:Ljava/lang/StringBuffer;

    invoke-virtual {v6}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setAnswer(Ljava/lang/String;)V

    .line 785
    move-object/from16 v6, p2

    invoke-virtual {v3, v6}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setImageUrl(Ljava/lang/String;)V

    .line 786
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    invoke-virtual {v3, v7, v8}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setTime(J)V

    .line 788
    move-object/from16 v7, p0

    invoke-direct {v7, v3}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->upsertChatRecord(Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;)V

    .line 791
    sget-object v8, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v10, "sendChatContent answer:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->getAnswer()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v8, v9}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_2

    .line 780
    .end local v3    # "bean":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    :cond_5
    move-object/from16 v7, p0

    move-object/from16 v5, p1

    move-object/from16 v6, p2

    .line 793
    :goto_2
    sget-object v3, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mAiChatListener:Ljava/lang/ref/WeakReference;

    if-eqz v3, :cond_6

    invoke-virtual {v3}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v3

    move-object v4, v3

    check-cast v4, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    :cond_6
    move-object v3, v4

    .line 794
    .local v3, "aiChatListener":Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;
    if-eqz v3, :cond_7

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getAnswer()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v3, v0, v4, v1}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onAiChatAnswer(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 795
    :cond_7
    invoke-virtual {v2, v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setAnswerIsFinish(Z)V

    .line 796
    sget-object v4, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v4

    invoke-virtual {v4, v2}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    .line 797
    .local v4, "extraStr":Ljava/lang/String;
    sget-object v8, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v9, "extraStr"

    invoke-static {v4, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v14, 0x1c

    const/4 v15, 0x0

    const-string v9, "AI_CHAT_API_ACTION"

    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    move-object v10, v4

    invoke-static/range {v8 .. v15}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 798
    return-void
.end method

.method static synthetic sendChatContent$default(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZILjava/lang/Object;)V
    .locals 7

    .line 768
    and-int/lit8 p7, p6, 0x1

    const-string v0, ""

    if-eqz p7, :cond_0

    move-object v2, v0

    goto :goto_0

    :cond_0
    move-object v2, p1

    :goto_0
    and-int/lit8 p1, p6, 0x2

    if-eqz p1, :cond_1

    move-object v3, v0

    goto :goto_1

    :cond_1
    move-object v3, p2

    :goto_1
    move-object v1, p0

    move-object v4, p3

    move-object v5, p4

    move v6, p5

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->sendChatContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V

    return-void
.end method

.method private final sendChatImgIntent(Ljava/lang/String;Ljava/lang/String;)V
    .locals 10
    .param p1, "intent"    # Ljava/lang/String;
    .param p2, "question"    # Ljava/lang/String;

    .line 890
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "sendChatIntent-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 892
    new-instance v0, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendChatImgIntent_u24lambda_u2426":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const/4 v2, 0x0

    .line 893
    .local v2, "$i$a$-apply-AIChatServiceImpl$sendChatImgIntent$extra$1":I
    const-string v3, "onAiIntent"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMethodName(Ljava/lang/String;)V

    .line 894
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setIntent(Ljava/lang/String;)V

    .line 895
    invoke-virtual {v1, p2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setQuestion(Ljava/lang/String;)V

    .line 896
    nop

    .line 892
    .end local v1    # "$this$sendChatImgIntent_u24lambda_u2426":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v2    # "$i$a$-apply-AIChatServiceImpl$sendChatImgIntent$extra$1":I
    nop

    .line 897
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 898
    .local v1, "extraStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "extraStr"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "AI_CHAT_API_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 899
    return-void
.end method

.method private final sendError()V
    .locals 10

    .line 872
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "sendError-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 876
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mAiChatListener:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    if-eqz v0, :cond_0

    const-string v1, "AI\u8bc6\u522b\u670d\u52a1\u51fa\u73b0\u9519\u8bef\uff0c\u8bf7\u7a0d\u540e\u91cd\u8bd5"

    const/4 v2, 0x1

    const-string v3, ""

    invoke-interface {v0, v3, v1, v2}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onAiChatAnswer(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 879
    :cond_0
    new-instance v0, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendError_u24lambda_u2425":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const/4 v2, 0x0

    .line 880
    .local v2, "$i$a$-apply-AIChatServiceImpl$sendError$extra$1":I
    const-string v3, "onError"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMethodName(Ljava/lang/String;)V

    .line 881
    nop

    .line 879
    .end local v1    # "$this$sendError_u24lambda_u2425":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v2    # "$i$a$-apply-AIChatServiceImpl$sendError$extra$1":I
    nop

    .line 882
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 883
    .local v1, "extraStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "extraStr"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "AI_CHAT_API_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 884
    return-void
.end method

.method public static synthetic toAiChat$default(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;Lcom/rokid/security/sdk/base/common/AiChatExtra;ZILjava/lang/Object;)V
    .locals 0

    .line 367
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    const/4 p2, 0x0

    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->toAiChat(Lcom/rokid/security/sdk/base/common/AiChatExtra;Z)V

    return-void
.end method

.method private final upsertChatRecord(Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;)V
    .locals 7
    .param p1, "bean"    # Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;

    .line 935
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->chatList:Ljava/util/List;

    monitor-enter v0

    const/4 v1, 0x0

    .line 936
    .local v1, "$i$a$-synchronized-AIChatServiceImpl$upsertChatRecord$1":I
    :try_start_0
    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->getQuestionId()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    if-eqz v2, :cond_0

    move-object v4, v2

    .line 1034
    .local v4, "it":Ljava/lang/String;
    const/4 v5, 0x0

    .line 936
    .local v5, "$i$a$-takeIf-AIChatServiceImpl$upsertChatRecord$1$questionId$1":I
    move-object v6, v4

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v6}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v6

    xor-int/lit8 v6, v6, 0x1

    .end local v4    # "it":Ljava/lang/String;
    .end local v5    # "$i$a$-takeIf-AIChatServiceImpl$upsertChatRecord$1$questionId$1":I
    if-eqz v6, :cond_0

    goto :goto_0

    :cond_0
    move-object v2, v3

    .line 937
    .local v2, "questionId":Ljava/lang/String;
    :goto_0
    if-nez v2, :cond_1

    .line 938
    sget-object v3, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->chatList:Ljava/util/List;

    invoke-interface {v3, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 939
    nop

    .end local v1    # "$i$a$-synchronized-AIChatServiceImpl$upsertChatRecord$1":I
    .end local v2    # "questionId":Ljava/lang/String;
    monitor-exit v0

    return-void

    .line 942
    .restart local v1    # "$i$a$-synchronized-AIChatServiceImpl$upsertChatRecord$1":I
    .restart local v2    # "questionId":Ljava/lang/String;
    :cond_1
    const/4 v3, -0x1

    .line 943
    .local v3, "replaceIndex":I
    :try_start_1
    sget-object v4, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->chatList:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    add-int/lit8 v4, v4, -0x1

    if-ltz v4, :cond_5

    :cond_2
    move v5, v4

    .local v5, "index":I
    add-int/lit8 v4, v4, -0x1

    .line 944
    sget-object v6, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->chatList:Ljava/util/List;

    invoke-interface {v6, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;

    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->getQuestionId()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_4

    .line 945
    if-gez v3, :cond_3

    .line 946
    move v3, v5

    goto :goto_1

    .line 948
    :cond_3
    sget-object v6, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->chatList:Ljava/util/List;

    invoke-interface {v6, v5}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 949
    add-int/lit8 v3, v3, -0x1

    .line 943
    :cond_4
    :goto_1
    if-gez v4, :cond_2

    .line 953
    .end local v5    # "index":I
    :cond_5
    if-ltz v3, :cond_6

    .line 954
    sget-object v4, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->chatList:Ljava/util/List;

    invoke-interface {v4, v3, p1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    .line 956
    :cond_6
    sget-object v4, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->chatList:Ljava/util/List;

    invoke-interface {v4, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 958
    :goto_2
    sget-object v4, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "upsertChatRecord questionId="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " chatList="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    sget-object v6, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->chatList:Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 959
    nop

    .end local v1    # "$i$a$-synchronized-AIChatServiceImpl$upsertChatRecord$1":I
    .end local v2    # "questionId":Ljava/lang/String;
    .end local v3    # "replaceIndex":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 935
    monitor-exit v0

    .line 960
    return-void

    .line 935
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method


# virtual methods
.method public final getCurrentAiChatExtra()Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .locals 1

    .line 68
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->currentAiChatExtra:Lcom/rokid/security/sdk/base/common/AiChatExtra;

    return-object v0
.end method

.method public final getGuideSessionId()Ljava/lang/String;
    .locals 1

    .line 71
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->guideSessionId:Ljava/lang/String;

    return-object v0
.end method

.method public final getMAiChatListener()Ljava/lang/ref/WeakReference;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/ref/WeakReference<",
            "Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;",
            ">;"
        }
    .end annotation

    .line 67
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mAiChatListener:Ljava/lang/ref/WeakReference;

    return-object v0
.end method

.method public final getMGson()Lcom/google/gson/Gson;
    .locals 1

    .line 75
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mGson:Lcom/google/gson/Gson;

    return-object v0
.end method

.method public final getMOkHttpSSEClient()Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;
    .locals 1

    .line 76
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    return-object v0
.end method

.method public getRunTimeChatList()Ljava/util/List;
    .locals 18
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;",
            ">;"
        }
    .end annotation

    .line 922
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->chatList:Ljava/util/List;

    monitor-enter v1

    const/4 v0, 0x0

    .line 923
    .local v0, "$i$a$-synchronized-AIChatServiceImpl$getRunTimeChatList$1":I
    :try_start_0
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    .line 924
    .local v2, "seenQuestionIds":Ljava/util/HashSet;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->chatList:Ljava/util/List;

    invoke-static {v3}, Lkotlin/collections/CollectionsKt;->asReversedMutable(Ljava/util/List;)Ljava/util/List;

    move-result-object v3

    check-cast v3, Ljava/lang/Iterable;

    .line 925
    nop

    .local v3, "$this$filter$iv":Ljava/lang/Iterable;
    const/4 v4, 0x0

    .line 1041
    .local v4, "$i$f$filter":I
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    check-cast v5, Ljava/util/Collection;

    .local v5, "destination$iv$iv":Ljava/util/Collection;
    move-object v6, v3

    .local v6, "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    const/4 v7, 0x0

    .line 1042
    .local v7, "$i$f$filterTo":I
    invoke-interface {v6}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :cond_0
    :goto_0
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_4

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    .local v9, "element$iv$iv":Ljava/lang/Object;
    move-object v10, v9

    check-cast v10, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;

    .local v10, "chat":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    const/4 v11, 0x0

    .line 926
    .local v11, "$i$a$-filter-AIChatServiceImpl$getRunTimeChatList$1$1":I
    invoke-virtual {v10}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->getQuestionId()Ljava/lang/String;

    move-result-object v12

    const/4 v13, 0x1

    const/4 v14, 0x0

    if-eqz v12, :cond_1

    move-object v15, v12

    .line 1034
    .local v15, "it":Ljava/lang/String;
    const/16 v16, 0x0

    .line 926
    .local v16, "$i$a$-takeIf-AIChatServiceImpl$getRunTimeChatList$1$1$questionId$1":I
    move-object/from16 v17, v15

    check-cast v17, Ljava/lang/CharSequence;

    invoke-static/range {v17 .. v17}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v17

    xor-int/lit8 v17, v17, 0x1

    .end local v15    # "it":Ljava/lang/String;
    .end local v16    # "$i$a$-takeIf-AIChatServiceImpl$getRunTimeChatList$1$1$questionId$1":I
    if-eqz v17, :cond_1

    goto :goto_1

    :cond_1
    move-object v12, v14

    .line 927
    .local v12, "questionId":Ljava/lang/String;
    :goto_1
    if-eqz v12, :cond_3

    invoke-virtual {v2, v12}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_2

    goto :goto_2

    :cond_2
    const/4 v13, 0x0

    .line 1042
    .end local v10    # "chat":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    .end local v11    # "$i$a$-filter-AIChatServiceImpl$getRunTimeChatList$1$1":I
    .end local v12    # "questionId":Ljava/lang/String;
    :cond_3
    :goto_2
    if-eqz v13, :cond_0

    invoke-interface {v5, v9}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 1043
    .end local v9    # "element$iv$iv":Ljava/lang/Object;
    :cond_4
    nop

    .end local v5    # "destination$iv$iv":Ljava/util/Collection;
    .end local v6    # "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    .end local v7    # "$i$f$filterTo":I
    check-cast v5, Ljava/util/List;

    .line 1041
    nop

    .line 929
    .end local v3    # "$this$filter$iv":Ljava/lang/Iterable;
    .end local v4    # "$i$f$filter":I
    invoke-static {v5}, Lkotlin/collections/CollectionsKt;->asReversed(Ljava/util/List;)Ljava/util/List;

    move-result-object v3

    check-cast v3, Ljava/util/Collection;

    .line 930
    invoke-static {v3}, Lkotlin/collections/CollectionsKt;->toMutableList(Ljava/util/Collection;)Ljava/util/List;

    move-result-object v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 922
    .end local v0    # "$i$a$-synchronized-AIChatServiceImpl$getRunTimeChatList$1":I
    .end local v2    # "seenQuestionIds":Ljava/util/HashSet;
    monitor-exit v1

    return-object v3

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public final getUseBase64Image()Z
    .locals 1

    .line 66
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->useBase64Image:Z

    return v0
.end method

.method public final goIntent$sdk_server_release(Ljava/lang/String;)V
    .locals 7
    .param p1, "question"    # Ljava/lang/String;

    const-string v0, "question"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 625
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "goIntent-->"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 626
    new-instance v0, Lcom/rokid/security/phone/sdk/server/aichat/data/IntentParam;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/aichat/data/IntentParam;-><init>()V

    move-object v1, v0

    .local v1, "$this$goIntent_u24lambda_u2415":Lcom/rokid/security/phone/sdk/server/aichat/data/IntentParam;
    const/4 v2, 0x0

    .line 627
    .local v2, "$i$a$-apply-AIChatServiceImpl$goIntent$mIntentParam$1":I
    invoke-virtual {v1, p1}, Lcom/rokid/security/phone/sdk/server/aichat/data/IntentParam;->setText(Ljava/lang/String;)V

    .line 628
    nop

    .line 626
    .end local v1    # "$this$goIntent_u24lambda_u2415":Lcom/rokid/security/phone/sdk/server/aichat/data/IntentParam;
    .end local v2    # "$i$a$-apply-AIChatServiceImpl$goIntent$mIntentParam$1":I
    nop

    .line 630
    .local v0, "mIntentParam":Lcom/rokid/security/phone/sdk/server/aichat/data/IntentParam;
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$goIntent$1;

    const/4 v3, 0x0

    invoke-direct {v2, v0, p1, v3}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$goIntent$1;-><init>(Lcom/rokid/security/phone/sdk/server/aichat/data/IntentParam;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v4, v2

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v2, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 654
    return-void
.end method

.method public final initAIChat()V
    .locals 2

    .line 97
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 98
    new-instance v0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    .line 99
    return-void
.end method

.method public final isCustom()Z
    .locals 1

    .line 132
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->isCustom:Z

    return v0
.end method

.method public final onMessage(Ljava/lang/String;)V
    .locals 6
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 138
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "AI_CHAT_MIRROR_ACTION"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 139
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->handleMirrorMessage(Ljava/lang/String;)V

    .line 140
    return-void

    .line 143
    :cond_0
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "AI_CHAT_API_ACTION"

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 144
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "onMessage:"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->sanitizeLargePayloadLog(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v3, 0x20

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 145
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    const-class v1, Lcom/rokid/security/sdk/base/common/RkBaseData;

    invoke-virtual {v0, p1, v1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData;

    .line 146
    .local v0, "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData;->getExtra()Ljava/lang/String;

    move-result-object v3

    const-class v4, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-virtual {v1, v3, v4}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 148
    .local v1, "mAiChatExtra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v3

    const-string v4, "ToInspect"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 151
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v3

    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestion()Ljava/lang/String;

    move-result-object v4

    const-class v5, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-virtual {v3, v4, v5}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 150
    nop

    .line 152
    .local v3, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v4

    const-string v5, "guideAIChatBegin"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 153
    sget-object v4, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v5, "\u8fdb\u5165ai\u95ee\u7b54 "

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 154
    const/4 v4, 0x1

    sput-boolean v4, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->isCustom:Z

    .line 156
    :cond_1
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v4

    const-string v5, "guideAIChatEnd"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 157
    sget-object v4, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v5, "\u9000\u51faai\u95ee\u7b54 "

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 158
    sput-boolean v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->isCustom:Z

    .line 163
    .end local v3    # "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    :cond_2
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    const-string/jumbo v3, "startAiChat"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 165
    sget-object v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v3, "\u542f\u52a8AI\u804a\u5929"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 166
    return-void

    .line 168
    :cond_3
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    const-string/jumbo v3, "toAiChat"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 169
    const-string v2, "mAiChatExtra"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-boolean v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->isCustom:Z

    invoke-virtual {p0, v1, v2}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->toAiChat(Lcom/rokid/security/sdk/base/common/AiChatExtra;Z)V

    goto :goto_0

    .line 170
    :cond_4
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    const-string/jumbo v3, "stopAiChat"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 171
    sget-object v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    if-eqz v2, :cond_5

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->close()V

    .line 177
    .end local v0    # "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    .end local v1    # "mAiChatExtra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    :cond_5
    :goto_0
    return-void
.end method

.method public removeAiChatListener()V
    .locals 1

    .line 918
    const/4 v0, 0x0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mAiChatListener:Ljava/lang/ref/WeakReference;

    .line 919
    return-void
.end method

.method public setAiChatListener(Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 914
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mAiChatListener:Ljava/lang/ref/WeakReference;

    .line 915
    return-void
.end method

.method public final setCurrentAiChatExtra(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 68
    sput-object p1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->currentAiChatExtra:Lcom/rokid/security/sdk/base/common/AiChatExtra;

    return-void
.end method

.method public final setCustom(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 132
    sput-boolean p1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->isCustom:Z

    return-void
.end method

.method public final setGuideSessionId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 71
    sput-object p1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->guideSessionId:Ljava/lang/String;

    return-void
.end method

.method public final setMAiChatListener(Ljava/lang/ref/WeakReference;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/ref/WeakReference<",
            "Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;",
            ">;)V"
        }
    .end annotation

    .line 67
    sput-object p1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mAiChatListener:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method public final setMGson(Lcom/google/gson/Gson;)V
    .locals 1
    .param p1, "<set-?>"    # Lcom/google/gson/Gson;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 75
    sput-object p1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mGson:Lcom/google/gson/Gson;

    return-void
.end method

.method public final setMOkHttpSSEClient(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    .line 76
    sput-object p1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    return-void
.end method

.method public final setUseBase64Image(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 66
    sput-boolean p1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->useBase64Image:Z

    return-void
.end method

.method public final toAiChat(Lcom/rokid/security/sdk/base/common/AiChatExtra;Z)V
    .locals 28
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .param p2, "isCustom"    # Z

    const-string v0, "extra"

    move-object/from16 v10, p1

    invoke-static {v10, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 368
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->curAnswerContent:Ljava/lang/StringBuffer;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 369
    new-instance v0, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v0}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    .local v0, "question":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestion()Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 370
    new-instance v2, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v2}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v11, v2

    .local v11, "imageUrl":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getImageUrl()Ljava/lang/String;

    move-result-object v2

    iput-object v2, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 371
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getImageId()Ljava/lang/String;

    move-result-object v12

    .line 372
    .local v12, "imageId":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getImagePath()Ljava/lang/String;

    move-result-object v13

    .line 373
    .local v13, "imgPath":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getImageBase64()Ljava/lang/String;

    move-result-object v14

    .line 375
    .local v14, "imageBase64":Ljava/lang/String;
    new-instance v2, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v2}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v15, v2

    .local v15, "questionId":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "randomUUID().toString()"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    iput-object v2, v15, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 376
    new-instance v8, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v8, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    .line 377
    .local v8, "terminalHandled":Ljava/util/concurrent/atomic/AtomicBoolean;
    new-instance v2, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v2}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v9, v2

    .local v9, "aiChatParam":Lkotlin/jvm/internal/Ref$ObjectRef;
    new-instance v2, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;

    invoke-direct {v2}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;-><init>()V

    iput-object v2, v9, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 378
    iget-object v2, v9, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    check-cast v3, Ljava/util/List;

    invoke-virtual {v2, v3}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;->setMessages(Ljava/util/List;)V

    .line 380
    new-instance v2, Lcom/rokid/security/phone/sdk/server/aichat/data/AiMessages;

    invoke-direct {v2}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiMessages;-><init>()V

    move-object v7, v2

    .line 381
    .local v7, "mAiMessages":Lcom/rokid/security/phone/sdk/server/aichat/data/AiMessages;
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    check-cast v2, Ljava/util/List;

    invoke-virtual {v7, v2}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiMessages;->setContents(Ljava/util/List;)V

    .line 383
    sget-object v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "toAiChat-->"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

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

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 384
    new-instance v2, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;

    invoke-direct {v2}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;-><init>()V

    move-object v6, v2

    .line 385
    .local v6, "textAiContent":Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;
    iget-object v2, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v6, v2}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;->setText(Ljava/lang/String;)V

    .line 386
    const-string/jumbo v2, "text"

    invoke-virtual {v6, v2}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;->setType(Ljava/lang/String;)V

    .line 398
    move-object v2, v14

    check-cast v2, Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-lez v2, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    move v2, v1

    :goto_0
    const-string v4, " imgPath:"

    const-string v5, "imageUrl-->"

    const-string v1, "imageNativeUri.toString()"

    const-string v3, ".fileprovider"

    const-string v10, "image/jpeg"

    move-object/from16 v18, v12

    .end local v12    # "imageId":Ljava/lang/String;
    .local v18, "imageId":Ljava/lang/String;
    const-string v12, "image_base64"

    if-eqz v2, :cond_5

    .line 400
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v2

    move-object/from16 v19, v8

    .end local v8    # "terminalHandled":Ljava/util/concurrent/atomic/AtomicBoolean;
    .local v19, "terminalHandled":Ljava/util/concurrent/atomic/AtomicBoolean;
    const-string v8, "receiver"

    invoke-virtual {v2, v8}, Landroid/app/Application;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    .line 401
    .local v2, "appPrivateDir":Ljava/io/File;
    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v8

    if-nez v8, :cond_2

    .line 402
    :cond_1
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    .line 405
    :cond_2
    new-instance v8, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;

    invoke-direct {v8}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;-><init>()V

    .line 406
    .local v8, "imgAiContent":Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;
    invoke-virtual {v8, v12}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;->setType(Ljava/lang/String;)V

    .line 407
    invoke-virtual {v8, v10}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;->setMimeType(Ljava/lang/String;)V

    .line 408
    invoke-virtual {v8, v14}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;->setData(Ljava/lang/String;)V

    .line 409
    invoke-virtual {v7}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiMessages;->getContents()Ljava/util/List;

    move-result-object v10

    if-eqz v10, :cond_3

    invoke-interface {v10, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 410
    :cond_3
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "image-"

    invoke-virtual {v10, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    move-object/from16 v20, v14

    move-object/from16 v21, v15

    .end local v14    # "imageBase64":Ljava/lang/String;
    .end local v15    # "questionId":Lkotlin/jvm/internal/Ref$ObjectRef;
    .local v20, "imageBase64":Ljava/lang/String;
    .local v21, "questionId":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v14

    invoke-virtual {v10, v14, v15}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v14, "-aiPic.webp"

    invoke-virtual {v10, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    .line 412
    .local v10, "fileName":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getAiImageType()Ljava/lang/String;

    move-result-object v14

    const-string v15, "jpg"

    invoke-static {v14, v15}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_4

    .line 413
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v14, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v14

    invoke-virtual {v12, v14, v15}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v14, "-aiPic.jpg"

    invoke-virtual {v12, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    .line 416
    :cond_4
    new-instance v12, Ljava/io/File;

    invoke-direct {v12, v2, v10}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 417
    .local v12, "outputFile":Ljava/io/File;
    sget-object v14, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;

    invoke-virtual {v8}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;->getData()Ljava/lang/String;

    move-result-object v15

    move-object/from16 v16, v2

    .end local v2    # "appPrivateDir":Ljava/io/File;
    .local v16, "appPrivateDir":Ljava/io/File;
    invoke-virtual {v12}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    move-object/from16 v17, v8

    .end local v8    # "imgAiContent":Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;
    .local v17, "imgAiContent":Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;
    const-string v8, "outputFile.absolutePath"

    invoke-static {v2, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v14, v15, v2}, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->base64ToImageFile(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    .line 418
    .local v2, "success":Z
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v8

    check-cast v8, Landroid/content/Context;

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v15

    invoke-virtual {v15}, Landroid/app/Application;->getPackageName()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v8, v3, v12}, Landroidx/core/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object v3

    .line 419
    .local v3, "imageNativeUri":Landroid/net/Uri;
    invoke-virtual {v3}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v26, 0x4

    const/16 v27, 0x0

    const-string v23, "content:"

    const-string v24, "https:"

    const/16 v25, 0x0

    move-object/from16 v22, v8

    invoke-static/range {v22 .. v27}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 421
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v8, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v8, Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v1, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .end local v2    # "success":Z
    .end local v3    # "imageNativeUri":Landroid/net/Uri;
    .end local v10    # "fileName":Ljava/lang/String;
    .end local v12    # "outputFile":Ljava/io/File;
    .end local v16    # "appPrivateDir":Ljava/io/File;
    .end local v17    # "imgAiContent":Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;
    goto/16 :goto_2

    .line 425
    .end local v19    # "terminalHandled":Ljava/util/concurrent/atomic/AtomicBoolean;
    .end local v20    # "imageBase64":Ljava/lang/String;
    .end local v21    # "questionId":Lkotlin/jvm/internal/Ref$ObjectRef;
    .local v8, "terminalHandled":Ljava/util/concurrent/atomic/AtomicBoolean;
    .restart local v14    # "imageBase64":Ljava/lang/String;
    .restart local v15    # "questionId":Lkotlin/jvm/internal/Ref$ObjectRef;
    :cond_5
    move-object/from16 v19, v8

    move-object/from16 v20, v14

    move-object/from16 v21, v15

    .end local v8    # "terminalHandled":Ljava/util/concurrent/atomic/AtomicBoolean;
    .end local v14    # "imageBase64":Ljava/lang/String;
    .end local v15    # "questionId":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v19    # "terminalHandled":Ljava/util/concurrent/atomic/AtomicBoolean;
    .restart local v20    # "imageBase64":Ljava/lang/String;
    .restart local v21    # "questionId":Lkotlin/jvm/internal/Ref$ObjectRef;
    move-object v2, v13

    check-cast v2, Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-lez v2, :cond_6

    const/16 v16, 0x1

    goto :goto_1

    :cond_6
    const/16 v16, 0x0

    :goto_1
    if-eqz v16, :cond_9

    new-instance v2, Ljava/io/File;

    invoke-direct {v2, v13}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_9

    .line 427
    new-instance v2, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;

    invoke-direct {v2}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;-><init>()V

    .line 428
    .local v2, "imgAiContent":Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;
    invoke-virtual {v2, v12}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;->setType(Ljava/lang/String;)V

    .line 429
    invoke-virtual {v2, v10}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;->setMimeType(Ljava/lang/String;)V

    .line 430
    sget-object v8, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;

    invoke-virtual {v8, v13}, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->fileToBase64(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    if-nez v8, :cond_7

    const-string v8, ""

    :cond_7
    invoke-virtual {v2, v8}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;->setData(Ljava/lang/String;)V

    .line 431
    invoke-virtual {v7}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiMessages;->getContents()Ljava/util/List;

    move-result-object v8

    if-eqz v8, :cond_8

    invoke-interface {v8, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 433
    :cond_8
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v8

    check-cast v8, Landroid/content/Context;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v12

    invoke-virtual {v12}, Landroid/app/Application;->getPackageName()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v10, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-instance v10, Ljava/io/File;

    invoke-direct {v10, v13}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v8, v3, v10}, Landroidx/core/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object v3

    .line 434
    .restart local v3    # "imageNativeUri":Landroid/net/Uri;
    invoke-virtual {v3}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v26, 0x4

    const/16 v27, 0x0

    const-string v23, "content:"

    const-string v24, "https:"

    const/16 v25, 0x0

    move-object/from16 v22, v8

    invoke-static/range {v22 .. v27}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 436
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v8, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v8, Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v1, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 441
    .end local v2    # "imgAiContent":Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;
    .end local v3    # "imageNativeUri":Landroid/net/Uri;
    :cond_9
    :goto_2
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->mAiChatListener:Ljava/lang/ref/WeakReference;

    if-eqz v1, :cond_a

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    goto :goto_3

    :cond_a
    const/4 v1, 0x0

    :goto_3
    move-object v10, v1

    .line 442
    .local v10, "aiChatListener":Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;
    if-eqz v10, :cond_b

    move-object/from16 v12, v21

    .end local v21    # "questionId":Lkotlin/jvm/internal/Ref$ObjectRef;
    .local v12, "questionId":Lkotlin/jvm/internal/Ref$ObjectRef;
    iget-object v1, v12, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestion()Ljava/lang/String;

    move-result-object v2

    iget-object v3, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v3, Ljava/lang/String;

    invoke-interface {v10, v1, v2, v3}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onAIChatQuestion(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_4

    .end local v12    # "questionId":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v21    # "questionId":Lkotlin/jvm/internal/Ref$ObjectRef;
    :cond_b
    move-object/from16 v12, v21

    .line 443
    .end local v21    # "questionId":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v12    # "questionId":Lkotlin/jvm/internal/Ref$ObjectRef;
    :goto_4
    invoke-virtual {v7}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiMessages;->getContents()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_c

    invoke-interface {v1, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 444
    :cond_c
    iget-object v1, v9, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;->getMessages()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_d

    invoke-interface {v1, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 448
    :cond_d
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "onChatAi-->"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 449
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v21

    new-instance v14, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;

    const/4 v8, 0x0

    move-object v1, v14

    move-object v2, v9

    move-object/from16 v3, p1

    move/from16 v4, p2

    move-object v5, v0

    move-object v15, v6

    .end local v6    # "textAiContent":Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;
    .local v15, "textAiContent":Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;
    move-object v6, v11

    move-object/from16 v16, v7

    .end local v7    # "mAiMessages":Lcom/rokid/security/phone/sdk/server/aichat/data/AiMessages;
    .local v16, "mAiMessages":Lcom/rokid/security/phone/sdk/server/aichat/data/AiMessages;
    move-object v7, v12

    move-object/from16 v17, v9

    .end local v9    # "aiChatParam":Lkotlin/jvm/internal/Ref$ObjectRef;
    .local v17, "aiChatParam":Lkotlin/jvm/internal/Ref$ObjectRef;
    move-object v9, v8

    move-object/from16 v8, v19

    .end local v19    # "terminalHandled":Ljava/util/concurrent/atomic/AtomicBoolean;
    .restart local v8    # "terminalHandled":Ljava/util/concurrent/atomic/AtomicBoolean;
    invoke-direct/range {v1 .. v9}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/sdk/base/common/AiChatExtra;ZLkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/coroutines/Continuation;)V

    move-object/from16 v24, v14

    check-cast v24, Lkotlin/jvm/functions/Function2;

    const/16 v25, 0x3

    const/16 v26, 0x0

    const/16 v22, 0x0

    const/16 v23, 0x0

    invoke-static/range {v21 .. v26}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 499
    return-void
.end method

.method public toChat(Ljava/lang/String;)V
    .locals 3
    .param p1, "question"    # Ljava/lang/String;

    const-string v0, "question"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 902
    new-instance v0, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$toChat_u24lambda_u2427":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const/4 v2, 0x0

    .line 903
    .local v2, "$i$a$-apply-AIChatServiceImpl$toChat$mAiChatExtra$1":I
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setQuestion(Ljava/lang/String;)V

    .line 904
    nop

    .line 902
    .end local v1    # "$this$toChat_u24lambda_u2427":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v2    # "$i$a$-apply-AIChatServiceImpl$toChat$mAiChatExtra$1":I
    nop

    .line 905
    .local v0, "mAiChatExtra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->toProductRec(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    .line 906
    return-void
.end method

.method public final toProductRec(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 13
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    const-string v0, "extra"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 551
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestion()Ljava/lang/String;

    move-result-object v0

    .line 552
    .local v0, "question":Ljava/lang/String;
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getImageUrl()Ljava/lang/String;

    move-result-object v1

    .line 553
    .local v1, "imageUrl":Ljava/lang/String;
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getUseBase64Image()Z

    move-result v2

    .line 559
    .local v2, "useBase64Image":Z
    const/4 v3, 0x2

    new-array v3, v3, [Lkotlin/Pair;

    const-string v4, "promptType"

    const-string v5, "customsGoods"

    invoke-static {v4, v5}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v4

    const/4 v5, 0x0

    aput-object v4, v3, v5

    .line 560
    const-string/jumbo v4, "text"

    invoke-static {v4, v0}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v4

    const/4 v6, 0x1

    aput-object v4, v3, v6

    .line 559
    nop

    .line 558
    invoke-static {v3}, Lkotlin/collections/MapsKt;->mutableMapOf([Lkotlin/Pair;)Ljava/util/Map;

    move-result-object v3

    .line 564
    .local v3, "paramMap":Ljava/util/Map;
    const-string v4, "imageUrl"

    if-eqz v2, :cond_5

    .line 566
    invoke-direct {p0, v1}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->convertImageUrlToBase64(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 567
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

    .line 568
    const-string v4, "file64"

    invoke-interface {v3, v4, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 569
    sget-object v4, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

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

    .line 572
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

    .line 573
    invoke-interface {v3, v4, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 575
    :cond_4
    sget-object v4, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

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

    .line 578
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

    .line 579
    invoke-interface {v3, v4, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 581
    :cond_7
    sget-object v4, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

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

    .line 585
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

    .line 586
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getSessionId()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    const-string/jumbo v5, "sessionId"

    invoke-interface {v3, v5, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 589
    :cond_a
    new-instance v4, Lcom/google/gson/Gson;

    invoke-direct {v4}, Lcom/google/gson/Gson;-><init>()V

    invoke-virtual {v4, v3}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    .line 590
    .local v4, "param":Ljava/lang/String;
    sget-object v5, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->TAG:Ljava/lang/String;

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

    .line 592
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v7

    new-instance v5, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toProductRec$1;

    const/4 v6, 0x0

    invoke-direct {v5, v4, v6}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toProductRec$1;-><init>(Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v10, v5

    check-cast v10, Lkotlin/jvm/functions/Function2;

    const/4 v11, 0x3

    const/4 v12, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    invoke-static/range {v7 .. v12}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 619
    return-void
.end method
