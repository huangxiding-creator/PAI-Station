.class public final Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/aichat/api/AbsIdentificationService;
.source "HgIdentificationServiceImpl.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nHgIdentificationServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 HgIdentificationServiceImpl.kt\ncom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl\n+ 2 MapsJVM.kt\nkotlin/collections/MapsKt__MapsJVMKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 4 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,677:1\n73#2,2:678\n1#3:680\n1#3:681\n533#4,6:682\n1855#4,2:688\n533#4,6:690\n766#4:696\n857#4,2:697\n*S KotlinDebug\n*F\n+ 1 HgIdentificationServiceImpl.kt\ncom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl\n*L\n171#1:678,2\n171#1:680\n308#1:682,6\n530#1:688,2\n590#1:690,6\n629#1:696\n629#1:697,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0087\u0001\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010!\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010#\n\u0000\n\u0002\u0010\"\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0005\n\u0002\u0010\u0012\n\u0002\u0008\u0016\n\u0002\u0018\u0002\n\u0002\u0008\n*\u0001\u0019\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010*\u001a\u00020+2\u0006\u0010)\u001a\u00020\u0004H\u0002J\u000e\u0010,\u001a\u0008\u0012\u0004\u0012\u00020\u00080\u0007H\u0016J \u0010-\u001a\u00020.2\u0006\u0010)\u001a\u00020\u00042\u0006\u0010/\u001a\u00020\u00042\u0006\u00100\u001a\u00020.H\u0002J\u0018\u00101\u001a\u00020+2\u0006\u00102\u001a\u00020\u00042\u0006\u00103\u001a\u000204H\u0002J\u0010\u00105\u001a\u00020+2\u0006\u00106\u001a\u00020\u0004H\u0002J\u0006\u00107\u001a\u00020+J\u0006\u00108\u001a\u00020+J\u0012\u00109\u001a\u00020.2\u0008\u0010:\u001a\u0004\u0018\u00010\u0004H\u0002J0\u0010;\u001a\u00020+2\u0006\u0010<\u001a\u00020\u00042\u0006\u0010=\u001a\u00020\u00042\u0006\u0010>\u001a\u00020\u00042\u0006\u0010?\u001a\u00020\u00042\u0006\u0010@\u001a\u00020\u0004H\u0002J\u0010\u0010A\u001a\u00020.2\u0006\u0010)\u001a\u00020\u0004H\u0002J\u000e\u0010B\u001a\u00020+2\u0006\u00106\u001a\u00020\u0004J\u0008\u0010C\u001a\u00020+H\u0016J\u0010\u0010D\u001a\u00020\u00042\u0006\u0010E\u001a\u00020(H\u0002J\u0010\u0010F\u001a\u00020\u00042\u0006\u00106\u001a\u00020\u0004H\u0002J\u0018\u0010G\u001a\u00020\u00042\u0006\u00103\u001a\u0002042\u0006\u0010)\u001a\u00020\u0004H\u0002J@\u0010H\u001a\u00020+2\u0006\u0010)\u001a\u00020\u00042\n\u0008\u0002\u0010I\u001a\u0004\u0018\u00010\u00042\u0008\u0010J\u001a\u0004\u0018\u00010K2\u0006\u0010L\u001a\u00020.2\u0006\u0010M\u001a\u00020\u00042\u0008\u0008\u0002\u00100\u001a\u00020.H\u0002J\u0008\u0010N\u001a\u00020+H\u0002J\u0010\u0010O\u001a\u00020+2\u0006\u0010P\u001a\u00020\u0011H\u0016J\u0010\u0010Q\u001a\u00020+2\u0006\u0010>\u001a\u00020\u0004H\u0016J\u000e\u0010R\u001a\u00020+2\u0006\u0010E\u001a\u00020(J\u0010\u0010S\u001a\u00020+2\u0006\u0010T\u001a\u00020\u0008H\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0006\u001a\u0008\u0012\u0004\u0012\u00020\u00080\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\nX\u0082\u000e\u00a2\u0006\u0002\n\u0000R2\u0010\u000b\u001a&\u0012\u000c\u0012\n \r*\u0004\u0018\u00010\u00040\u0004 \r*\u0012\u0012\u000c\u0012\n \r*\u0004\u0018\u00010\u00040\u0004\u0018\u00010\u000e0\u000cX\u0082\u0004\u00a2\u0006\u0002\n\u0000R2\u0010\u000f\u001a&\u0012\u000c\u0012\n \r*\u0004\u0018\u00010\u00040\u0004 \r*\u0012\u0012\u000c\u0012\n \r*\u0004\u0018\u00010\u00040\u0004\u0018\u00010\u000e0\u000cX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001c\u0010\u0010\u001a\u0004\u0018\u00010\u0011X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0012\u0010\u0013\"\u0004\u0008\u0014\u0010\u0015R\u000e\u0010\u0016\u001a\u00020\u0017X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0018\u001a\u00020\u0019X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u001aR\u001c\u0010\u001b\u001a\u0004\u0018\u00010\u001cX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001d\u0010\u001e\"\u0004\u0008\u001f\u0010 R\u001e\u0010!\u001a\u0012\u0012\u0004\u0012\u00020\u0004\u0012\u0008\u0012\u00060#j\u0002`$0\"X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010%\u001a\u000e\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020\u00040\"X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010&\u001a\u000e\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020\u00040\"X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010\'\u001a\u000e\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020(0\"X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010)\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006U"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/aichat/api/AbsIdentificationService;",
        "()V",
        "MIRROR_IMAGE_STREAM_PREFIX",
        "",
        "TAG",
        "chatList",
        "",
        "Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;",
        "curAnswerContent",
        "Ljava/lang/StringBuffer;",
        "finishedMirrorQuestions",
        "",
        "kotlin.jvm.PlatformType",
        "",
        "handledMirrorSeqs",
        "mAiChatListener",
        "Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;",
        "getMAiChatListener",
        "()Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;",
        "setMAiChatListener",
        "(Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;)V",
        "mGson",
        "Lcom/google/gson/Gson;",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$mInterMessageListener$1;",
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
        "Lcom/rokid/security/sdk/base/common/IdentificationExtra;",
        "questionId",
        "finishMirrorIdentification",
        "",
        "getRunTimeChatList",
        "handleAiMessage",
        "",
        "message",
        "isModify",
        "handleMirrorImageStream",
        "tag",
        "data",
        "",
        "handleMirrorMessage",
        "msg",
        "identificationEnd",
        "initIdentification",
        "isDuplicateMirror",
        "seq",
        "logIdentificationRequest",
        "url",
        "appId",
        "question",
        "imageBase64",
        "payload",
        "markMirrorFinished",
        "onMessage",
        "removeAiChatListener",
        "resolveMirrorImageUrl",
        "extra",
        "sanitizeLargePayloadLog",
        "saveMirrorImageBytes",
        "sendChatContent",
        "imageUrl",
        "content",
        "Lcom/rokid/security/sdk/base/common/aichat/AiContent;",
        "isFinish",
        "inputType",
        "sendError",
        "setAiChatListener",
        "listener",
        "toChat",
        "toIdentification",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;

.field private static final MIRROR_IMAGE_STREAM_PREFIX:Ljava/lang/String; = "HG_IDENTIFICATION_MIRROR_IMAGE:"

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

.field private static final finishedMirrorQuestions:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final handledMirrorSeqs:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static mAiChatListener:Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

.field private static mGson:Lcom/google/gson/Gson;

.field private static final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$mInterMessageListener$1;

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
            "Lcom/rokid/security/sdk/base/common/IdentificationExtra;",
            ">;"
        }
    .end annotation
.end field

.field private static questionId:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;

    .line 47
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->curAnswerContent:Ljava/lang/StringBuffer;

    .line 49
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mGson:Lcom/google/gson/Gson;

    .line 53
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    check-cast v0, Ljava/util/List;

    sput-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->chatList:Ljava/util/List;

    .line 54
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    invoke-static {v0}, Ljava/util/Collections;->synchronizedSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->handledMirrorSeqs:Ljava/util/Set;

    .line 55
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    invoke-static {v0}, Ljava/util/Collections;->synchronizedSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    .line 56
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mirrorAnswerBuffers:Ljava/util/concurrent/ConcurrentHashMap;

    .line 57
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mirrorImageUrls:Ljava/util/concurrent/ConcurrentHashMap;

    .line 58
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mirrorImageTags:Ljava/util/concurrent/ConcurrentHashMap;

    .line 59
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mirrorQuestions:Ljava/util/concurrent/ConcurrentHashMap;

    .line 61
    const-string v0, "HgIdentificationServiceImpl::"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    .line 72
    new-instance v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$mInterMessageListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$mInterMessageListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$mInterMessageListener$1;

    .line 328
    const-string v0, ""

    sput-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->questionId:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 45
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/aichat/api/AbsIdentificationService;-><init>()V

    return-void
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 45
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$handleAiMessage(Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;Ljava/lang/String;Ljava/lang/String;Z)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;
    .param p1, "questionId"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .param p3, "isModify"    # Z

    .line 45
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->handleAiMessage(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method public static final synthetic access$handleMirrorImageStream(Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;Ljava/lang/String;[B)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B

    .line 45
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->handleMirrorImageStream(Ljava/lang/String;[B)V

    return-void
.end method

.method public static final synthetic access$logIdentificationRequest(Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "appId"    # Ljava/lang/String;
    .param p3, "question"    # Ljava/lang/String;
    .param p4, "imageBase64"    # Ljava/lang/String;
    .param p5, "payload"    # Ljava/lang/String;

    .line 45
    invoke-direct/range {p0 .. p5}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->logIdentificationRequest(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$sendChatContent(Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;
    .param p1, "questionId"    # Ljava/lang/String;
    .param p2, "imageUrl"    # Ljava/lang/String;
    .param p3, "content"    # Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .param p4, "isFinish"    # Z
    .param p5, "inputType"    # Ljava/lang/String;
    .param p6, "isModify"    # Z

    .line 45
    invoke-direct/range {p0 .. p6}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->sendChatContent(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;Z)V

    return-void
.end method

.method public static final synthetic access$sendError(Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;

    .line 45
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->sendError()V

    return-void
.end method

.method private final finishMirrorIdentification(Ljava/lang/String;)V
    .locals 12
    .param p1, "questionId"    # Ljava/lang/String;

    .line 305
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mirrorAnswerBuffers:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/StringBuilder;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    move-object v0, v1

    :goto_0
    if-nez v0, :cond_1

    const-string v0, ""

    .line 306
    .local v0, "answer":Ljava/lang/String;
    :cond_1
    sget-object v2, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mirrorQuestions:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v2, p1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    .line 307
    .local v2, "question":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->chatList:Ljava/util/List;

    monitor-enter v3

    const/4 v4, 0x0

    .line 308
    .local v4, "$i$a$-synchronized-HgIdentificationServiceImpl$finishMirrorIdentification$oldChatBean$1":I
    :try_start_0
    sget-object v5, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->chatList:Ljava/util/List;

    .local v5, "$this$lastOrNull$iv":Ljava/util/List;
    const/4 v6, 0x0

    .line 682
    .local v6, "$i$f$lastOrNull":I
    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v7

    invoke-interface {v5, v7}, Ljava/util/List;->listIterator(I)Ljava/util/ListIterator;

    move-result-object v7

    .line 683
    .local v7, "iterator$iv":Ljava/util/ListIterator;
    :cond_2
    invoke-interface {v7}, Ljava/util/ListIterator;->hasPrevious()Z

    move-result v8

    if-eqz v8, :cond_3

    .line 684
    invoke-interface {v7}, Ljava/util/ListIterator;->previous()Ljava/lang/Object;

    move-result-object v8

    .line 685
    .local v8, "element$iv":Ljava/lang/Object;
    move-object v9, v8

    check-cast v9, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;

    .local v9, "it":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    const/4 v10, 0x0

    .line 308
    .local v10, "$i$a$-lastOrNull-HgIdentificationServiceImpl$finishMirrorIdentification$oldChatBean$1$1":I
    invoke-virtual {v9}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->getQuestionId()Ljava/lang/String;

    move-result-object v11

    invoke-static {v11, p1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v11

    .line 685
    .end local v9    # "it":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    .end local v10    # "$i$a$-lastOrNull-HgIdentificationServiceImpl$finishMirrorIdentification$oldChatBean$1$1":I
    if-eqz v11, :cond_2

    goto :goto_1

    .line 687
    .end local v8    # "element$iv":Ljava/lang/Object;
    :cond_3
    move-object v8, v1

    .end local v5    # "$this$lastOrNull$iv":Ljava/util/List;
    .end local v6    # "$i$f$lastOrNull":I
    .end local v7    # "iterator$iv":Ljava/util/ListIterator;
    :goto_1
    check-cast v8, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 308
    nop

    .line 307
    .end local v4    # "$i$a$-synchronized-HgIdentificationServiceImpl$finishMirrorIdentification$oldChatBean$1":I
    monitor-exit v3

    move-object v3, v8

    .line 310
    .local v3, "oldChatBean":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mirrorImageUrls:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v4, p1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    if-nez v4, :cond_4

    const-string v4, ""

    :cond_4
    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_7

    const/4 v4, 0x0

    .line 311
    .local v4, "$i$a$-ifBlank-HgIdentificationServiceImpl$finishMirrorIdentification$imageUrl$1":I
    if-eqz v3, :cond_5

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->getImageUrl()Ljava/lang/String;

    move-result-object v5

    goto :goto_2

    :cond_5
    move-object v5, v1

    :goto_2
    if-nez v5, :cond_6

    const-string v5, ""

    .line 310
    .end local v4    # "$i$a$-ifBlank-HgIdentificationServiceImpl$finishMirrorIdentification$imageUrl$1":I
    :cond_6
    move-object v4, v5

    :cond_7
    check-cast v4, Ljava/lang/String;

    .line 313
    .local v4, "imageUrl":Ljava/lang/String;
    const/4 v5, 0x1

    if-nez v2, :cond_9

    move-object v6, v0

    check-cast v6, Ljava/lang/CharSequence;

    invoke-interface {v6}, Ljava/lang/CharSequence;->length()I

    move-result v6

    if-lez v6, :cond_8

    move v6, v5

    goto :goto_3

    :cond_8
    const/4 v6, 0x0

    :goto_3
    if-eqz v6, :cond_c

    .line 314
    :cond_9
    new-instance v6, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;

    invoke-direct {v6}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;-><init>()V

    move-object v7, v6

    .local v7, "$this$finishMirrorIdentification_u24lambda_u2414":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    const/4 v8, 0x0

    .line 315
    .local v8, "$i$a$-apply-HgIdentificationServiceImpl$finishMirrorIdentification$1":I
    invoke-virtual {v7, p1}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setQuestionId(Ljava/lang/String;)V

    .line 316
    if-eqz v2, :cond_a

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getQuestion()Ljava/lang/String;

    move-result-object v1

    :cond_a
    if-nez v1, :cond_b

    const-string v1, ""

    :cond_b
    invoke-virtual {v7, v1}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setQuestion(Ljava/lang/String;)V

    .line 317
    invoke-virtual {v7, v0}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setAnswer(Ljava/lang/String;)V

    .line 318
    invoke-virtual {v7, v4}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setImageUrl(Ljava/lang/String;)V

    .line 319
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    invoke-virtual {v7, v9, v10}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setTime(J)V

    .line 320
    invoke-virtual {v7, v5}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setSourceType(I)V

    .line 321
    nop

    .line 314
    .end local v7    # "$this$finishMirrorIdentification_u24lambda_u2414":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    .end local v8    # "$i$a$-apply-HgIdentificationServiceImpl$finishMirrorIdentification$1":I
    invoke-direct {p0, v6}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->upsertChatRecord(Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;)V

    .line 323
    :cond_c
    return-void

    .line 307
    .end local v3    # "oldChatBean":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    .end local v4    # "imageUrl":Ljava/lang/String;
    :catchall_0
    move-exception v1

    monitor-exit v3

    throw v1
.end method

.method private final handleAiMessage(Ljava/lang/String;Ljava/lang/String;Z)Z
    .locals 21
    .param p1, "questionId"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .param p3, "isModify"    # Z

    .line 521
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

    .line 522
    return v3

    .line 524
    :cond_1
    new-instance v1, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$handleAiMessage$type$1;

    invoke-direct {v1}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$handleAiMessage$type$1;-><init>()V

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$handleAiMessage$type$1;->getType()Ljava/lang/reflect/Type;

    move-result-object v1

    .line 525
    .local v1, "type":Ljava/lang/reflect/Type;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mGson:Lcom/google/gson/Gson;

    invoke-virtual {v4, v0, v1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/reflect/Type;)Ljava/lang/Object;

    move-result-object v4

    const-string v5, "mGson.fromJson(message, type)"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v4, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;

    .line 526
    .local v4, "aiResponse":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    sget-object v5, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

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

    .line 527
    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getCode()Ljava/lang/Integer;

    move-result-object v5

    if-nez v5, :cond_3

    goto/16 :goto_4

    :cond_3
    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    if-nez v5, :cond_8

    .line 528
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

    .line 530
    .local v5, "$i$a$-let-HgIdentificationServiceImpl$handleAiMessage$1":I
    move-object v6, v2

    check-cast v6, Ljava/lang/Iterable;

    .local v6, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v7, 0x0

    .line 688
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
    move-object/from16 v19, v9

    check-cast v19, Lcom/rokid/security/sdk/base/common/aichat/AiContent;

    .local v19, "content":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    const/16 v20, 0x0

    .line 532
    .local v20, "$i$a$-forEach-HgIdentificationServiceImpl$handleAiMessage$1$1":I
    invoke-virtual/range {v19 .. v19}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getType()Ljava/lang/String;

    move-result-object v10

    const-string/jumbo v11, "text"

    invoke-static {v10, v11}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_4

    .line 533
    sget-object v10, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;

    const/16 v17, 0x20

    const/16 v18, 0x0

    const-string v12, ""

    const/4 v14, 0x0

    const-string v15, "Inputing"

    const/16 v16, 0x0

    move-object/from16 v11, p1

    move-object/from16 v13, v19

    invoke-static/range {v10 .. v18}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->sendChatContent$default(Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;ZILjava/lang/Object;)V

    goto :goto_3

    .line 534
    :cond_4
    invoke-virtual/range {v19 .. v19}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getType()Ljava/lang/String;

    move-result-object v10

    const-string/jumbo v11, "thinking"

    invoke-static {v10, v11}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_5

    .line 535
    sget-object v10, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;

    const/16 v17, 0x20

    const/16 v18, 0x0

    const-string v12, ""

    const/4 v14, 0x0

    const-string v15, "Thinking"

    const/16 v16, 0x0

    move-object/from16 v11, p1

    move-object/from16 v13, v19

    invoke-static/range {v10 .. v18}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->sendChatContent$default(Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;ZILjava/lang/Object;)V

    .line 538
    :cond_5
    :goto_3
    nop

    .line 688
    .end local v19    # "content":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .end local v20    # "$i$a$-forEach-HgIdentificationServiceImpl$handleAiMessage$1$1":I
    nop

    .end local v9    # "element$iv":Ljava/lang/Object;
    goto :goto_2

    .line 689
    :cond_6
    nop

    .line 539
    .end local v6    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v7    # "$i$f$forEach":I
    nop

    .line 528
    .end local v2    # "contents":Ljava/util/List;
    .end local v5    # "$i$a$-let-HgIdentificationServiceImpl$handleAiMessage$1":I
    :cond_7
    nop

    .line 540
    return v3

    .line 542
    :cond_8
    :goto_4
    sget-object v3, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

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

    .line 543
    return v2
.end method

.method private final handleMirrorImageStream(Ljava/lang/String;[B)V
    .locals 5
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B

    .line 207
    const-string v0, "HG_IDENTIFICATION_MIRROR_IMAGE:"

    const/4 v1, 0x0

    const/4 v2, 0x2

    const/4 v3, 0x0

    invoke-static {p1, v0, v1, v2, v3}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    return-void

    .line 208
    :cond_0
    sget-object v1, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mirrorImageTags:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v1, p1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    if-nez v1, :cond_1

    .line 209
    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {p1, v0}, Lkotlin/text/StringsKt;->removePrefix(Ljava/lang/String;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v1, ":"

    invoke-static {v0, v1, v3, v2, v3}, Lkotlin/text/StringsKt;->substringBefore$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 208
    :cond_1
    const-string v0, "mirrorImageTags.remove(t\u2026FIX).substringBefore(\":\")"

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v0, v1

    .line 210
    .local v0, "questionId":Ljava/lang/String;
    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 211
    sget-object v1, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

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

    .line 212
    return-void

    .line 214
    :cond_2
    invoke-direct {p0, p2, v0}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->saveMirrorImageBytes([BLjava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 215
    .local v1, "imageUrl":Ljava/lang/String;
    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_3

    return-void

    .line 216
    :cond_3
    sget-object v2, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mirrorImageUrls:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v2, Ljava/util/Map;

    invoke-interface {v2, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 217
    sget-object v2, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mirrorQuestions:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    .line 218
    .local v2, "question":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mAiChatListener:Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    if-eqz v4, :cond_6

    if-eqz v2, :cond_4

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getQuestion()Ljava/lang/String;

    move-result-object v3

    :cond_4
    if-nez v3, :cond_5

    const-string v3, ""

    :cond_5
    invoke-interface {v4, v0, v3, v1}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onAIChatQuestion(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 219
    :cond_6
    return-void
.end method

.method private final handleMirrorMessage(Ljava/lang/String;)V
    .locals 12
    .param p1, "msg"    # Ljava/lang/String;

    .line 128
    :try_start_0
    sget-object v0, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v0, p0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;

    .local v0, "$this$handleMirrorMessage_u24lambda_u242":Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;
    const/4 v1, 0x0

    .line 129
    .local v1, "$i$a$-runCatching-HgIdentificationServiceImpl$handleMirrorMessage$1":I
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    const-class v3, Lcom/rokid/security/sdk/base/common/RkBaseData;

    invoke-virtual {v2, p1, v3}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/rokid/security/sdk/base/common/RkBaseData;

    .line 130
    .local v2, "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v3

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/RkBaseData;->getExtra()Ljava/lang/String;

    move-result-object v4

    const-class v5, Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    invoke-virtual {v3, v4, v5}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    .line 131
    .local v3, "extra":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getMirrorSeq()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v0, v4}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->isDuplicateMirror(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 132
    sget-object v4, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "handleMirrorMessage duplicate seq="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getMirrorSeq()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 133
    return-void

    .line 135
    :cond_0
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getQuestionId()Ljava/lang/String;

    move-result-object v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const-string v5, ""

    if-nez v4, :cond_1

    move-object v4, v5

    .line 136
    .local v4, "questionId":Ljava/lang/String;
    :cond_1
    :try_start_1
    move-object v6, v4

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v6}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 137
    sget-object v5, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "handleMirrorMessage ignored empty questionId, method="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getMethodName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 138
    return-void

    .line 141
    :cond_2
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getMethodName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/String;->hashCode()I

    move-result v7

    const/4 v8, 0x1

    sparse-switch v7, :sswitch_data_0

    :goto_0
    goto/16 :goto_5

    :sswitch_0
    const-string v7, "mirrorQuestion"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_3

    goto :goto_0

    .line 143
    :cond_3
    sget-object v6, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    invoke-interface {v6, v4}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 144
    sget-object v6, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mirrorAnswerBuffers:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v6, Ljava/util/Map;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {v6, v4, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 145
    sget-object v6, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mirrorQuestions:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v6, Ljava/util/Map;

    const-string v7, "extra"

    invoke-static {v3, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v6, v4, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 146
    invoke-direct {v0, v3}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->resolveMirrorImageUrl(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)Ljava/lang/String;

    move-result-object v6

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v6}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_5

    const/4 v6, 0x0

    .line 147
    .local v6, "$i$a$-ifBlank-HgIdentificationServiceImpl$handleMirrorMessage$1$imageUrl$1":I
    sget-object v7, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mirrorImageUrls:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v7, v4}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    if-nez v7, :cond_4

    goto :goto_1

    :cond_4
    move-object v5, v7

    .line 146
    .end local v6    # "$i$a$-ifBlank-HgIdentificationServiceImpl$handleMirrorMessage$1$imageUrl$1":I
    :goto_1
    move-object v6, v5

    :cond_5
    check-cast v6, Ljava/lang/String;

    move-object v5, v6

    .line 149
    .local v5, "imageUrl":Ljava/lang/String;
    move-object v6, v5

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v6}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v6

    xor-int/2addr v6, v8

    if-eqz v6, :cond_6

    .line 150
    sget-object v6, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mirrorImageUrls:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v6, Ljava/util/Map;

    invoke-interface {v6, v4, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 152
    :cond_6
    sget-object v6, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mAiChatListener:Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    if-eqz v6, :cond_14

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getQuestion()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v6, v4, v7, v5}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onAIChatQuestion(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_6

    .line 141
    .end local v5    # "imageUrl":Ljava/lang/String;
    :sswitch_1
    const-string v5, "mirrorModify"

    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_7

    goto :goto_0

    .line 156
    :cond_7
    sget-object v5, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    invoke-interface {v5, v4}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 157
    sget-object v5, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mirrorAnswerBuffers:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v5, Ljava/util/Map;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {v5, v4, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 158
    sget-object v5, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mAiChatListener:Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    if-eqz v5, :cond_14

    invoke-interface {v5, v4}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onModify(Ljava/lang/String;)V

    goto/16 :goto_6

    .line 141
    :sswitch_2
    const-string v5, "mirrorResponse"

    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_8

    goto/16 :goto_0

    .line 169
    :cond_8
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getAnswer()Ljava/lang/String;

    move-result-object v5

    .line 170
    .local v5, "answer":Ljava/lang/String;
    move-object v6, v5

    check-cast v6, Ljava/lang/CharSequence;

    invoke-interface {v6}, Ljava/lang/CharSequence;->length()I

    move-result v6
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-lez v6, :cond_9

    goto :goto_2

    :cond_9
    const/4 v8, 0x0

    :goto_2
    const-string v6, "Thinking"

    if-eqz v8, :cond_c

    :try_start_2
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getContentType()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7, v6}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_c

    .line 171
    sget-object v7, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mirrorAnswerBuffers:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v7, Ljava/util/concurrent/ConcurrentMap;

    .local v7, "$this$getOrPut$iv":Ljava/util/concurrent/ConcurrentMap;
    const/4 v8, 0x0

    .line 678
    .local v8, "$i$f$getOrPut":I
    invoke-interface {v7, v4}, Ljava/util/concurrent/ConcurrentMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    if-nez v9, :cond_b

    .line 679
    const/4 v9, 0x0

    .line 171
    .local v9, "$i$a$-getOrPut-HgIdentificationServiceImpl$handleMirrorMessage$1$1":I
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    .line 679
    .end local v9    # "$i$a$-getOrPut-HgIdentificationServiceImpl$handleMirrorMessage$1$1":I
    move-object v9, v10

    .line 680
    .local v9, "default$iv":Ljava/lang/Object;
    const/4 v10, 0x0

    .line 679
    .local v10, "$i$a$-let-MapsKt__MapsJVMKt$getOrPut$1$iv":I
    invoke-interface {v7, v4, v9}, Ljava/util/concurrent/ConcurrentMap;->putIfAbsent(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11

    if-nez v11, :cond_a

    goto :goto_3

    :cond_a
    move-object v9, v11

    .line 678
    .end local v9    # "default$iv":Ljava/lang/Object;
    .end local v10    # "$i$a$-let-MapsKt__MapsJVMKt$getOrPut$1$iv":I
    :cond_b
    :goto_3
    nop

    .end local v7    # "$this$getOrPut$iv":Ljava/util/concurrent/ConcurrentMap;
    .end local v8    # "$i$f$getOrPut":I
    check-cast v9, Ljava/lang/StringBuilder;

    .line 171
    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 173
    :cond_c
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getAnswerIsFinish()Z

    move-result v7

    if-eqz v7, :cond_d

    invoke-direct {v0, v4}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->markMirrorFinished(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_d

    .line 174
    sget-object v6, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

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

    .line 175
    return-void

    .line 177
    :cond_d
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getContentType()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7, v6}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_e

    .line 178
    sget-object v6, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mAiChatListener:Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    if-eqz v6, :cond_e

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getAnswerIsFinish()Z

    move-result v7

    invoke-interface {v6, v4, v5, v7}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onAiChatAnswer(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 180
    :cond_e
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getAnswerIsFinish()Z

    move-result v6

    if-eqz v6, :cond_14

    .line 181
    invoke-direct {v0, v4}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->finishMirrorIdentification(Ljava/lang/String;)V

    .end local v5    # "answer":Ljava/lang/String;
    goto/16 :goto_6

    .line 141
    :sswitch_3
    const-string v7, "mirrorImage"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_f

    goto/16 :goto_0

    .line 162
    :cond_f
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getImageStreamTag()Ljava/lang/String;

    move-result-object v6

    if-nez v6, :cond_10

    goto :goto_4

    :cond_10
    move-object v5, v6

    .line 163
    .local v5, "streamTag":Ljava/lang/String;
    :goto_4
    move-object v6, v5

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v6}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v6

    xor-int/2addr v6, v8

    if-eqz v6, :cond_14

    .line 164
    sget-object v6, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mirrorImageTags:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v6, Ljava/util/Map;

    invoke-interface {v6, v5, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_6

    .line 141
    .end local v5    # "streamTag":Ljava/lang/String;
    :sswitch_4
    const-string v5, "mirrorError"

    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_11

    goto/16 :goto_0

    .line 186
    :cond_11
    invoke-direct {v0, v4}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->markMirrorFinished(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_12

    .line 187
    sget-object v5, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

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

    .line 188
    return-void

    .line 190
    :cond_12
    sget-object v5, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mAiChatListener:Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    if-eqz v5, :cond_13

    .line 191
    nop

    .line 192
    const-string v6, "AI\u8bc6\u522b\u670d\u52a1\u51fa\u73b0\u9519\u8bef\uff0c\u8bf7\u7a0d\u540e\u91cd\u8bd5"

    .line 193
    nop

    .line 190
    invoke-interface {v5, v4, v6, v8}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onAiChatAnswer(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 195
    :cond_13
    invoke-direct {v0, v4}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->finishMirrorIdentification(Ljava/lang/String;)V

    goto :goto_6

    .line 198
    :goto_5
    sget-object v5, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "handleMirrorMessage ignored method="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getMethodName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 200
    :cond_14
    :goto_6
    nop

    .line 201
    nop

    .end local v0    # "$this$handleMirrorMessage_u24lambda_u242":Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;
    .end local v1    # "$i$a$-runCatching-HgIdentificationServiceImpl$handleMirrorMessage$1":I
    .end local v2    # "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    .end local v3    # "extra":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    .end local v4    # "questionId":Ljava/lang/String;
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 128
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

    .line 201
    :goto_7
    invoke-static {v0}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v0

    if-eqz v0, :cond_15

    .local v0, "it":Ljava/lang/Throwable;
    const/4 v1, 0x0

    .line 202
    .local v1, "$i$a$-onFailure-HgIdentificationServiceImpl$handleMirrorMessage$2":I
    sget-object v2, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

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

    .line 203
    nop

    .line 201
    .end local v0    # "it":Ljava/lang/Throwable;
    .end local v1    # "$i$a$-onFailure-HgIdentificationServiceImpl$handleMirrorMessage$2":I
    nop

    .line 204
    :cond_15
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        -0x69630a77 -> :sswitch_4
        -0x692d3324 -> :sswitch_3
        -0x63fd4ae0 -> :sswitch_2
        0x4a77c559 -> :sswitch_1
        0x6acddcc5 -> :sswitch_0
    .end sparse-switch
.end method

.method private final isDuplicateMirror(Ljava/lang/String;)Z
    .locals 9
    .param p1, "seq"    # Ljava/lang/String;

    .line 270
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

    .line 271
    :cond_2
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->handledMirrorSeqs:Ljava/util/Set;

    const-string v3, "handledMirrorSeqs"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    monitor-enter v0

    const/4 v3, 0x0

    .line 272
    .local v3, "$i$a$-synchronized-HgIdentificationServiceImpl$isDuplicateMirror$1":I
    :try_start_0
    sget-object v4, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->handledMirrorSeqs:Ljava/util/Set;

    invoke-interface {v4, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v4, :cond_3

    .end local v3    # "$i$a$-synchronized-HgIdentificationServiceImpl$isDuplicateMirror$1":I
    monitor-exit v0

    return v1

    .line 273
    .restart local v3    # "$i$a$-synchronized-HgIdentificationServiceImpl$isDuplicateMirror$1":I
    :cond_3
    :try_start_1
    sget-object v1, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->handledMirrorSeqs:Ljava/util/Set;

    invoke-interface {v1, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 274
    sget-object v1, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->handledMirrorSeqs:Ljava/util/Set;

    invoke-interface {v1}, Ljava/util/Set;->size()I

    move-result v1

    const/16 v4, 0x12c

    if-le v1, v4, :cond_5

    .line 275
    sget-object v1, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->handledMirrorSeqs:Ljava/util/Set;

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .line 276
    .local v1, "iterator":Ljava/util/Iterator;
    sget-object v5, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->handledMirrorSeqs:Ljava/util/Set;

    invoke-interface {v5}, Ljava/util/Set;->size()I

    move-result v5

    sub-int/2addr v5, v4

    move v4, v2

    :goto_2
    if-ge v4, v5, :cond_5

    move v6, v4

    .local v6, "it":I
    const/4 v7, 0x0

    .line 277
    .local v7, "$i$a$-repeat-HgIdentificationServiceImpl$isDuplicateMirror$1$1":I
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_4

    .line 278
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 279
    invoke-interface {v1}, Ljava/util/Iterator;->remove()V

    .line 281
    :cond_4
    nop

    .line 276
    .end local v6    # "it":I
    .end local v7    # "$i$a$-repeat-HgIdentificationServiceImpl$isDuplicateMirror$1$1":I
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 283
    .end local v1    # "iterator":Ljava/util/Iterator;
    :cond_5
    nop

    .end local v3    # "$i$a$-synchronized-HgIdentificationServiceImpl$isDuplicateMirror$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 271
    monitor-exit v0

    .line 284
    return v2

    .line 271
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private final logIdentificationRequest(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 7
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "appId"    # Ljava/lang/String;
    .param p3, "question"    # Ljava/lang/String;
    .param p4, "imageBase64"    # Ljava/lang/String;
    .param p5, "payload"    # Ljava/lang/String;

    .line 488
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

    .line 489
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

    .line 490
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

    .line 492
    .local v1, "hasAgentHeader":Z
    sget-object v4, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    .line 493
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

    .line 491
    invoke-static {v4, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 495
    return-void
.end method

.method private final markMirrorFinished(Ljava/lang/String;)Z
    .locals 8
    .param p1, "questionId"    # Ljava/lang/String;

    .line 288
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    const-string v1, "finishedMirrorQuestions"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    monitor-enter v0

    const/4 v1, 0x0

    .line 289
    .local v1, "$i$a$-synchronized-HgIdentificationServiceImpl$markMirrorFinished$1":I
    :try_start_0
    sget-object v2, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    invoke-interface {v2, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v3, 0x0

    if-eqz v2, :cond_0

    .end local v1    # "$i$a$-synchronized-HgIdentificationServiceImpl$markMirrorFinished$1":I
    monitor-exit v0

    return v3

    .line 290
    .restart local v1    # "$i$a$-synchronized-HgIdentificationServiceImpl$markMirrorFinished$1":I
    :cond_0
    :try_start_1
    sget-object v2, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    invoke-interface {v2, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 291
    sget-object v2, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    invoke-interface {v2}, Ljava/util/Set;->size()I

    move-result v2

    const/16 v4, 0x64

    if-le v2, v4, :cond_2

    .line 292
    sget-object v2, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .line 293
    .local v2, "iterator":Ljava/util/Iterator;
    sget-object v5, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->finishedMirrorQuestions:Ljava/util/Set;

    invoke-interface {v5}, Ljava/util/Set;->size()I

    move-result v5

    sub-int/2addr v5, v4

    :goto_0
    if-ge v3, v5, :cond_2

    move v4, v3

    .local v4, "it":I
    const/4 v6, 0x0

    .line 294
    .local v6, "$i$a$-repeat-HgIdentificationServiceImpl$markMirrorFinished$1$1":I
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_1

    .line 295
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 296
    invoke-interface {v2}, Ljava/util/Iterator;->remove()V

    .line 298
    :cond_1
    nop

    .line 293
    .end local v4    # "it":I
    .end local v6    # "$i$a$-repeat-HgIdentificationServiceImpl$markMirrorFinished$1$1":I
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 300
    .end local v2    # "iterator":Ljava/util/Iterator;
    :cond_2
    nop

    .end local v1    # "$i$a$-synchronized-HgIdentificationServiceImpl$markMirrorFinished$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 288
    monitor-exit v0

    .line 301
    const/4 v0, 0x1

    return v0

    .line 288
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private final resolveMirrorImageUrl(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)Ljava/lang/String;
    .locals 11
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    .line 222
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getImageUrl()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getImageUrl()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 223
    :cond_0
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getImageBase64()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    const-string v1, ""

    if-eqz v0, :cond_1

    return-object v1

    .line 224
    :cond_1
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v0

    const-string v2, "receiver"

    invoke-virtual {v0, v2}, Landroid/app/Application;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    if-nez v0, :cond_2

    return-object v1

    .line 225
    .local v0, "appPrivateDir":Ljava/io/File;
    :cond_2
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_3

    .line 226
    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    .line 228
    :cond_3
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "image-"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "-aiPic.webp"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 229
    .local v2, "fileName":Ljava/lang/String;
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getAiImageType()Ljava/lang/String;

    move-result-object v4

    const-string v5, "jpg"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 230
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "-aiPic.jpg"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 232
    :cond_4
    new-instance v3, Ljava/io/File;

    invoke-direct {v3, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 233
    .local v3, "outputFile":Ljava/io/File;
    sget-object v4, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getImageBase64()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    const-string v7, "outputFile.absolutePath"

    invoke-static {v6, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v4, v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->base64ToImageFile(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    .line 234
    .local v4, "success":Z
    if-nez v4, :cond_5

    .line 235
    sget-object v5, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    const-string v6, "resolveMirrorImageUrl base64ToImageFile failed"

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 236
    return-object v1

    .line 239
    :cond_5
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    check-cast v1, Landroid/content/Context;

    .line 240
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v6

    invoke-virtual {v6}, Landroid/app/Application;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ".fileprovider"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 241
    nop

    .line 238
    invoke-static {v1, v5, v3}, Landroidx/core/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object v1

    .line 243
    .local v1, "imageNativeUri":Landroid/net/Uri;
    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v5

    const-string v6, "imageNativeUri.toString()"

    invoke-static {v5, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v9, 0x4

    const/4 v10, 0x0

    const-string v6, "content:"

    const-string v7, "https:"

    const/4 v8, 0x0

    invoke-static/range {v5 .. v10}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    .line 244
    .local v5, "imageUrl":Ljava/lang/String;
    sget-object v6, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "resolveMirrorImageUrl imageUrl="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " file="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-static {v6, v7}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 245
    return-object v5
.end method

.method private final sanitizeLargePayloadLog(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p1, "msg"    # Ljava/lang/String;

    .line 667
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

    .line 668
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    move-object v4, v2

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v0, v4, v3}, Lkotlin/text/StringsKt;->contains(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    move-result v0

    if-nez v0, :cond_0

    .line 669
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v4, 0x400

    if-gt v0, v4, :cond_0

    .line 671
    return-object p1

    .line 673
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

.method private final saveMirrorImageBytes([BLjava/lang/String;)Ljava/lang/String;
    .locals 12
    .param p1, "data"    # [B
    .param p2, "questionId"    # Ljava/lang/String;

    .line 249
    array-length v0, p1

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    const-string v1, ""

    if-eqz v0, :cond_1

    return-object v1

    .line 250
    :cond_1
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v0

    const-string v2, "receiver"

    invoke-virtual {v0, v2}, Landroid/app/Application;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    if-nez v0, :cond_2

    return-object v1

    .line 251
    .local v0, "appPrivateDir":Ljava/io/File;
    :cond_2
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_3

    .line 252
    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    .line 254
    :cond_3
    new-instance v2, Ljava/io/File;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "image-"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0x2d

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "-aiPic.jpg"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v0, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 255
    .local v2, "outputFile":Ljava/io/File;
    :try_start_0
    sget-object v3, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v3, p0

    check-cast v3, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;

    .local v3, "$this$saveMirrorImageBytes_u24lambda_u245":Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;
    const/4 v4, 0x0

    .local v4, "$i$a$-runCatching-HgIdentificationServiceImpl$saveMirrorImageBytes$1":I
    new-instance v5, Ljava/io/FileOutputStream;

    .line 256
    invoke-direct {v5, v2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    check-cast v5, Ljava/io/Closeable;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    :try_start_1
    move-object v6, v5

    check-cast v6, Ljava/io/FileOutputStream;

    .line 681
    .local v6, "it":Ljava/io/FileOutputStream;
    const/4 v7, 0x0

    .line 256
    .local v7, "$i$a$-use-HgIdentificationServiceImpl$saveMirrorImageBytes$1$1":I
    invoke-virtual {v6, p1}, Ljava/io/FileOutputStream;->write([B)V

    .end local v6    # "it":Ljava/io/FileOutputStream;
    .end local v7    # "$i$a$-use-HgIdentificationServiceImpl$saveMirrorImageBytes$1$1":I
    sget-object v6, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const/4 v6, 0x0

    :try_start_2
    invoke-static {v5, v6}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 258
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v5

    check-cast v5, Landroid/content/Context;

    .line 259
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v7

    invoke-virtual {v7}, Landroid/app/Application;->getPackageName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ".fileprovider"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 260
    nop

    .line 257
    invoke-static {v5, v6, v2}, Landroidx/core/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object v5

    .line 262
    .local v5, "imageNativeUri":Landroid/net/Uri;
    invoke-virtual {v5}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v6

    const-string v7, "imageNativeUri.toString()"

    invoke-static {v6, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v7, "content:"

    const-string v8, "https:"

    const/4 v10, 0x4

    const/4 v11, 0x0

    const/4 v9, 0x0

    invoke-static/range {v6 .. v11}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    .line 255
    .end local v3    # "$this$saveMirrorImageBytes_u24lambda_u245":Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;
    .end local v4    # "$i$a$-runCatching-HgIdentificationServiceImpl$saveMirrorImageBytes$1":I
    .end local v5    # "imageNativeUri":Landroid/net/Uri;
    invoke-static {v6}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    goto :goto_1

    .line 256
    .restart local v3    # "$this$saveMirrorImageBytes_u24lambda_u245":Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;
    .restart local v4    # "$i$a$-runCatching-HgIdentificationServiceImpl$saveMirrorImageBytes$1":I
    :catchall_0
    move-exception v6

    .end local v0    # "appPrivateDir":Ljava/io/File;
    .end local v2    # "outputFile":Ljava/io/File;
    .end local v3    # "$this$saveMirrorImageBytes_u24lambda_u245":Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;
    .end local v4    # "$i$a$-runCatching-HgIdentificationServiceImpl$saveMirrorImageBytes$1":I
    .end local p1    # "data":[B
    .end local p2    # "questionId":Ljava/lang/String;
    :try_start_3
    throw v6
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .restart local v0    # "appPrivateDir":Ljava/io/File;
    .restart local v2    # "outputFile":Ljava/io/File;
    .restart local v3    # "$this$saveMirrorImageBytes_u24lambda_u245":Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;
    .restart local v4    # "$i$a$-runCatching-HgIdentificationServiceImpl$saveMirrorImageBytes$1":I
    .restart local p1    # "data":[B
    .restart local p2    # "questionId":Ljava/lang/String;
    :catchall_1
    move-exception v7

    :try_start_4
    invoke-static {v5, v6}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v0    # "appPrivateDir":Ljava/io/File;
    .end local v2    # "outputFile":Ljava/io/File;
    .end local p1    # "data":[B
    .end local p2    # "questionId":Ljava/lang/String;
    throw v7
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 255
    .end local v3    # "$this$saveMirrorImageBytes_u24lambda_u245":Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;
    .end local v4    # "$i$a$-runCatching-HgIdentificationServiceImpl$saveMirrorImageBytes$1":I
    .restart local v0    # "appPrivateDir":Ljava/io/File;
    .restart local v2    # "outputFile":Ljava/io/File;
    .restart local p1    # "data":[B
    .restart local p2    # "questionId":Ljava/lang/String;
    :catchall_2
    move-exception v3

    sget-object v4, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v3}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 263
    :goto_1
    invoke-static {v3}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v4

    if-nez v4, :cond_4

    move-object v1, v3

    goto :goto_2

    :cond_4
    move-object v3, v4

    .local v3, "it":Ljava/lang/Throwable;
    const/4 v4, 0x0

    .line 264
    .local v4, "$i$a$-getOrElse-HgIdentificationServiceImpl$saveMirrorImageBytes$2":I
    sget-object v5, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v7, "saveMirrorImageBytes failed: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v3}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6, v3}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 265
    nop

    .line 263
    .end local v3    # "it":Ljava/lang/Throwable;
    .end local v4    # "$i$a$-getOrElse-HgIdentificationServiceImpl$saveMirrorImageBytes$2":I
    :goto_2
    check-cast v1, Ljava/lang/String;

    .line 255
    return-object v1
.end method

.method private final sendChatContent(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;Z)V
    .locals 19
    .param p1, "questionId"    # Ljava/lang/String;
    .param p2, "imageUrl"    # Ljava/lang/String;
    .param p3, "content"    # Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .param p4, "isFinish"    # Z
    .param p5, "inputType"    # Ljava/lang/String;
    .param p6, "isModify"    # Z

    .line 568
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move/from16 v3, p4

    move-object/from16 v4, p5

    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "sendChatContent-->"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    if-eqz p3, :cond_0

    invoke-virtual/range {p3 .. p3}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v7

    goto :goto_0

    :cond_0
    const/4 v7, 0x0

    :goto_0
    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v0, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 570
    new-instance v0, Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;-><init>()V

    move-object v5, v0

    .line 571
    .local v5, "extra":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    const-string v0, "onResponse"

    invoke-virtual {v5, v0}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setMethodName(Ljava/lang/String;)V

    .line 572
    invoke-virtual {v5, v4}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setContentType(Ljava/lang/String;)V

    .line 574
    if-eqz p3, :cond_1

    .line 575
    invoke-virtual/range {p3 .. p3}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setAnswer(Ljava/lang/String;)V

    .line 577
    :cond_1
    const-string v0, "Thinking"

    invoke-static {v4, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    const/4 v7, 0x0

    const/4 v8, 0x1

    if-nez v0, :cond_4

    if-eqz p3, :cond_3

    invoke-virtual/range {p3 .. p3}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_3

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-lez v0, :cond_2

    move v0, v8

    goto :goto_1

    :cond_2
    move v0, v7

    :goto_1
    if-ne v0, v8, :cond_3

    move v0, v8

    goto :goto_2

    :cond_3
    move v0, v7

    :goto_2
    if-eqz v0, :cond_4

    .line 578
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->curAnswerContent:Ljava/lang/StringBuffer;

    invoke-virtual/range {p3 .. p3}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v0, v9}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 580
    :cond_4
    if-eqz v3, :cond_d

    .line 581
    const/4 v0, 0x0

    .local v0, "bean":Ljava/lang/Object;
    new-instance v9, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;

    invoke-direct {v9}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;-><init>()V

    .line 582
    .end local v0    # "bean":Ljava/lang/Object;
    .local v9, "bean":Ljava/lang/Object;
    invoke-virtual {v9, v2}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setQuestionId(Ljava/lang/String;)V

    .line 583
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->curAnswerContent:Ljava/lang/StringBuffer;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v9, v0}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setAnswer(Ljava/lang/String;)V

    .line 584
    move-object/from16 v10, p2

    invoke-virtual {v9, v10}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setImageUrl(Ljava/lang/String;)V

    .line 585
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v11

    invoke-virtual {v9, v11, v12}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setTime(J)V

    .line 586
    invoke-virtual {v9, v8}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setSourceType(I)V

    .line 588
    if-eqz p6, :cond_c

    .line 589
    sget-object v11, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->chatList:Ljava/util/List;

    monitor-enter v11

    const/4 v0, 0x0

    .line 590
    .local v0, "$i$a$-synchronized-HgIdentificationServiceImpl$sendChatContent$1":I
    :try_start_0
    sget-object v12, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->chatList:Ljava/util/List;

    .local v12, "$this$lastOrNull$iv":Ljava/util/List;
    const/4 v13, 0x0

    .line 690
    .local v13, "$i$f$lastOrNull":I
    invoke-interface {v12}, Ljava/util/List;->size()I

    move-result v14

    invoke-interface {v12, v14}, Ljava/util/List;->listIterator(I)Ljava/util/ListIterator;

    move-result-object v14

    .line 691
    .local v14, "iterator$iv":Ljava/util/ListIterator;
    :cond_5
    invoke-interface {v14}, Ljava/util/ListIterator;->hasPrevious()Z

    move-result v15

    if-eqz v15, :cond_6

    .line 692
    invoke-interface {v14}, Ljava/util/ListIterator;->previous()Ljava/lang/Object;

    move-result-object v15

    .line 693
    .local v15, "element$iv":Ljava/lang/Object;
    move-object/from16 v16, v15

    check-cast v16, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;

    .local v16, "it":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    const/16 v17, 0x0

    .line 590
    .local v17, "$i$a$-lastOrNull-HgIdentificationServiceImpl$sendChatContent$1$oldChatBean$1":I
    invoke-virtual/range {v16 .. v16}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->getQuestionId()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v6

    .line 693
    .end local v16    # "it":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    .end local v17    # "$i$a$-lastOrNull-HgIdentificationServiceImpl$sendChatContent$1$oldChatBean$1":I
    if-eqz v6, :cond_5

    goto :goto_3

    .line 695
    .end local v15    # "element$iv":Ljava/lang/Object;
    :cond_6
    const/4 v15, 0x0

    .line 590
    .end local v12    # "$this$lastOrNull$iv":Ljava/util/List;
    .end local v13    # "$i$f$lastOrNull":I
    .end local v14    # "iterator$iv":Ljava/util/ListIterator;
    :goto_3
    check-cast v15, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;

    if-nez v15, :cond_7

    .line 591
    sget-object v6, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->chatList:Ljava/util/List;

    invoke-static {v6}, Lkotlin/collections/CollectionsKt;->lastOrNull(Ljava/util/List;)Ljava/lang/Object;

    move-result-object v6

    move-object v15, v6

    check-cast v15, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;

    .line 590
    :cond_7
    move-object v6, v15

    .line 592
    .local v6, "oldChatBean":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    invoke-virtual {v9}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->getImageUrl()Ljava/lang/String;

    move-result-object v12

    check-cast v12, Ljava/lang/CharSequence;

    if-eqz v12, :cond_8

    invoke-static {v12}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v12

    if-eqz v12, :cond_9

    :cond_8
    move v7, v8

    :cond_9
    if-eqz v7, :cond_b

    .line 593
    if-eqz v6, :cond_a

    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->getImageUrl()Ljava/lang/String;

    move-result-object v7

    goto :goto_4

    :cond_a
    const/4 v7, 0x0

    :goto_4
    invoke-virtual {v9, v7}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->setImageUrl(Ljava/lang/String;)V

    .line 595
    :cond_b
    nop

    .end local v0    # "$i$a$-synchronized-HgIdentificationServiceImpl$sendChatContent$1":I
    .end local v6    # "oldChatBean":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 589
    monitor-exit v11

    goto :goto_5

    :catchall_0
    move-exception v0

    monitor-exit v11

    throw v0

    .line 597
    :cond_c
    :goto_5
    invoke-direct {v1, v9}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->upsertChatRecord(Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;)V

    .line 598
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v7, "sendChatContent answer:"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v9}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->getAnswer()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v0, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_6

    .line 580
    .end local v9    # "bean":Ljava/lang/Object;
    :cond_d
    move-object/from16 v10, p2

    .line 601
    :goto_6
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mAiChatListener:Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    .line 602
    .local v0, "aiChatListener":Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;
    const-string v6, "Thinking"

    invoke-static {v4, v6}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_e

    .line 603
    if-eqz v0, :cond_e

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getAnswer()Ljava/lang/String;

    move-result-object v6

    invoke-interface {v0, v2, v6, v3}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onAiChatAnswer(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 607
    :cond_e
    invoke-virtual {v5, v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setAnswerIsFinish(Z)V

    .line 608
    sget-object v6, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v6

    invoke-virtual {v6, v5}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    .line 609
    .local v6, "extraStr":Ljava/lang/String;
    sget-object v7, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v9, "sendChatContent extraStr:"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "extraStr"

    invoke-static {v6, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {v1, v6}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->sanitizeLargePayloadLog(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 610
    sget-object v11, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v12, "HG_IDENTIFICATION_API_ACTION"

    const-string v7, "extraStr"

    invoke-static {v6, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v17, 0x1c

    const/16 v18, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object v13, v6

    invoke-static/range {v11 .. v18}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 611
    return-void
.end method

.method static synthetic sendChatContent$default(Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;ZILjava/lang/Object;)V
    .locals 7

    .line 567
    and-int/lit8 p8, p7, 0x2

    if-eqz p8, :cond_0

    const-string p2, ""

    :cond_0
    move-object v2, p2

    and-int/lit8 p2, p7, 0x20

    if-eqz p2, :cond_1

    const/4 p6, 0x0

    :cond_1
    move v6, p6

    move-object v0, p0

    move-object v1, p1

    move-object v3, p3

    move v4, p4

    move-object v5, p5

    invoke-direct/range {v0 .. v6}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->sendChatContent(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;Z)V

    return-void
.end method

.method private final sendError()V
    .locals 10

    .line 552
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "sendError-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 555
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mAiChatListener:Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    if-eqz v0, :cond_0

    const-string/jumbo v1, "\u670d\u52a1\u5f02\u5e38\uff0c\u8bf7\u7a0d\u540e\u91cd\u8bd5"

    const/4 v2, 0x1

    const-string v3, ""

    invoke-interface {v0, v3, v1, v2}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onAiChatAnswer(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 558
    :cond_0
    new-instance v0, Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendError_u24lambda_u2417":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    const/4 v2, 0x0

    .line 559
    .local v2, "$i$a$-apply-HgIdentificationServiceImpl$sendError$extra$1":I
    const-string v3, "onError"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->setMethodName(Ljava/lang/String;)V

    .line 560
    nop

    .line 558
    .end local v1    # "$this$sendError_u24lambda_u2417":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    .end local v2    # "$i$a$-apply-HgIdentificationServiceImpl$sendError$extra$1":I
    nop

    .line 561
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 562
    .local v1, "extraStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "extraStr"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "HG_IDENTIFICATION_API_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 563
    return-void
.end method

.method private final upsertChatRecord(Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;)V
    .locals 7
    .param p1, "bean"    # Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;

    .line 639
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->chatList:Ljava/util/List;

    monitor-enter v0

    const/4 v1, 0x0

    .line 640
    .local v1, "$i$a$-synchronized-HgIdentificationServiceImpl$upsertChatRecord$1":I
    :try_start_0
    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->getQuestionId()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    if-eqz v2, :cond_0

    move-object v4, v2

    .line 681
    .local v4, "it":Ljava/lang/String;
    const/4 v5, 0x0

    .line 640
    .local v5, "$i$a$-takeIf-HgIdentificationServiceImpl$upsertChatRecord$1$questionId$1":I
    move-object v6, v4

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v6}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v6

    xor-int/lit8 v6, v6, 0x1

    .end local v4    # "it":Ljava/lang/String;
    .end local v5    # "$i$a$-takeIf-HgIdentificationServiceImpl$upsertChatRecord$1$questionId$1":I
    if-eqz v6, :cond_0

    goto :goto_0

    :cond_0
    move-object v2, v3

    .line 641
    .local v2, "questionId":Ljava/lang/String;
    :goto_0
    if-nez v2, :cond_1

    .line 642
    sget-object v3, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->chatList:Ljava/util/List;

    invoke-interface {v3, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 643
    nop

    .end local v1    # "$i$a$-synchronized-HgIdentificationServiceImpl$upsertChatRecord$1":I
    .end local v2    # "questionId":Ljava/lang/String;
    monitor-exit v0

    return-void

    .line 646
    .restart local v1    # "$i$a$-synchronized-HgIdentificationServiceImpl$upsertChatRecord$1":I
    .restart local v2    # "questionId":Ljava/lang/String;
    :cond_1
    const/4 v3, -0x1

    .line 647
    .local v3, "replaceIndex":I
    :try_start_1
    sget-object v4, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->chatList:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    add-int/lit8 v4, v4, -0x1

    if-ltz v4, :cond_5

    :cond_2
    move v5, v4

    .local v5, "index":I
    add-int/lit8 v4, v4, -0x1

    .line 648
    sget-object v6, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->chatList:Ljava/util/List;

    invoke-interface {v6, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;

    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->getQuestionId()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_4

    .line 649
    if-gez v3, :cond_3

    .line 650
    move v3, v5

    goto :goto_1

    .line 652
    :cond_3
    sget-object v6, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->chatList:Ljava/util/List;

    invoke-interface {v6, v5}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 653
    add-int/lit8 v3, v3, -0x1

    .line 647
    :cond_4
    :goto_1
    if-gez v4, :cond_2

    .line 657
    .end local v5    # "index":I
    :cond_5
    if-ltz v3, :cond_6

    .line 658
    sget-object v4, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->chatList:Ljava/util/List;

    invoke-interface {v4, v3, p1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    .line 660
    :cond_6
    sget-object v4, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->chatList:Ljava/util/List;

    invoke-interface {v4, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 662
    :goto_2
    sget-object v4, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

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

    sget-object v6, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->chatList:Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 663
    nop

    .end local v1    # "$i$a$-synchronized-HgIdentificationServiceImpl$upsertChatRecord$1":I
    .end local v2    # "questionId":Ljava/lang/String;
    .end local v3    # "replaceIndex":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 639
    monitor-exit v0

    .line 664
    return-void

    .line 639
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method


# virtual methods
.method public final getMAiChatListener()Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;
    .locals 1

    .line 50
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mAiChatListener:Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    return-object v0
.end method

.method public final getMOkHttpSSEClient()Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;
    .locals 1

    .line 48
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

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

    .line 626
    sget-object v1, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->chatList:Ljava/util/List;

    monitor-enter v1

    const/4 v0, 0x0

    .line 627
    .local v0, "$i$a$-synchronized-HgIdentificationServiceImpl$getRunTimeChatList$1":I
    :try_start_0
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    .line 628
    .local v2, "seenQuestionIds":Ljava/util/HashSet;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->chatList:Ljava/util/List;

    invoke-static {v3}, Lkotlin/collections/CollectionsKt;->asReversedMutable(Ljava/util/List;)Ljava/util/List;

    move-result-object v3

    check-cast v3, Ljava/lang/Iterable;

    .line 629
    nop

    .local v3, "$this$filter$iv":Ljava/lang/Iterable;
    const/4 v4, 0x0

    .line 696
    .local v4, "$i$f$filter":I
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    check-cast v5, Ljava/util/Collection;

    .local v5, "destination$iv$iv":Ljava/util/Collection;
    move-object v6, v3

    .local v6, "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    const/4 v7, 0x0

    .line 697
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

    .line 630
    .local v11, "$i$a$-filter-HgIdentificationServiceImpl$getRunTimeChatList$1$1":I
    invoke-virtual {v10}, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->getQuestionId()Ljava/lang/String;

    move-result-object v12

    const/4 v13, 0x1

    const/4 v14, 0x0

    if-eqz v12, :cond_1

    move-object v15, v12

    .line 681
    .local v15, "it":Ljava/lang/String;
    const/16 v16, 0x0

    .line 630
    .local v16, "$i$a$-takeIf-HgIdentificationServiceImpl$getRunTimeChatList$1$1$questionId$1":I
    move-object/from16 v17, v15

    check-cast v17, Ljava/lang/CharSequence;

    invoke-static/range {v17 .. v17}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v17

    xor-int/lit8 v17, v17, 0x1

    .end local v15    # "it":Ljava/lang/String;
    .end local v16    # "$i$a$-takeIf-HgIdentificationServiceImpl$getRunTimeChatList$1$1$questionId$1":I
    if-eqz v17, :cond_1

    goto :goto_1

    :cond_1
    move-object v12, v14

    .line 631
    .local v12, "questionId":Ljava/lang/String;
    :goto_1
    if-eqz v12, :cond_3

    invoke-virtual {v2, v12}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_2

    goto :goto_2

    :cond_2
    const/4 v13, 0x0

    .line 697
    .end local v10    # "chat":Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
    .end local v11    # "$i$a$-filter-HgIdentificationServiceImpl$getRunTimeChatList$1$1":I
    .end local v12    # "questionId":Ljava/lang/String;
    :cond_3
    :goto_2
    if-eqz v13, :cond_0

    invoke-interface {v5, v9}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 698
    .end local v9    # "element$iv$iv":Ljava/lang/Object;
    :cond_4
    nop

    .end local v5    # "destination$iv$iv":Ljava/util/Collection;
    .end local v6    # "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    .end local v7    # "$i$f$filterTo":I
    check-cast v5, Ljava/util/List;

    .line 696
    nop

    .line 633
    .end local v3    # "$this$filter$iv":Ljava/lang/Iterable;
    .end local v4    # "$i$f$filter":I
    invoke-static {v5}, Lkotlin/collections/CollectionsKt;->asReversed(Ljava/util/List;)Ljava/util/List;

    move-result-object v3

    check-cast v3, Ljava/util/Collection;

    .line 634
    invoke-static {v3}, Lkotlin/collections/CollectionsKt;->toMutableList(Ljava/util/Collection;)Ljava/util/List;

    move-result-object v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 626
    .end local v0    # "$i$a$-synchronized-HgIdentificationServiceImpl$getRunTimeChatList$1":I
    .end local v2    # "seenQuestionIds":Ljava/util/HashSet;
    monitor-exit v1

    return-object v3

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public final identificationEnd()V
    .locals 8

    .line 501
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    const-string v1, "identificationEnd"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 502
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$identificationEnd$1;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$identificationEnd$1;-><init>(Lkotlin/coroutines/Continuation;)V

    move-object v5, v0

    check-cast v5, Lkotlin/jvm/functions/Function2;

    const/4 v6, 0x3

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static/range {v2 .. v7}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 513
    return-void
.end method

.method public final initIdentification()V
    .locals 2

    .line 64
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 65
    new-instance v0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    .line 66
    return-void
.end method

.method public final onMessage(Ljava/lang/String;)V
    .locals 5
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 103
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "HG_IDENTIFICATION_MIRROR_ACTION"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 104
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->handleMirrorMessage(Ljava/lang/String;)V

    .line 105
    return-void

    .line 108
    :cond_0
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "HG_IDENTIFICATION_API_ACTION"

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 109
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onMessage:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->sanitizeLargePayloadLog(Ljava/lang/String;)Ljava/lang/String;

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

    .line 110
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    const-class v1, Lcom/rokid/security/sdk/base/common/RkBaseData;

    invoke-virtual {v0, p1, v1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData;

    .line 111
    .local v0, "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData;->getExtra()Ljava/lang/String;

    move-result-object v2

    const-class v3, Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    invoke-virtual {v1, v2, v3}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    .line 113
    .local v1, "mIdentificationExtraExtra":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "execute"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    const-string v3, "mIdentificationExtraExtra"

    if-eqz v2, :cond_1

    .line 114
    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0, v1}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->toIdentification(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V

    goto :goto_0

    .line 115
    :cond_1
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    const-string v4, "modifyExecute"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 116
    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0, v1}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->toIdentification(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V

    goto :goto_0

    .line 117
    :cond_2
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    const-string/jumbo v3, "stopTask"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 118
    sget-object v2, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    if-eqz v2, :cond_5

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->close()V

    goto :goto_0

    .line 119
    :cond_3
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "end"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 120
    sget-object v2, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    if-eqz v2, :cond_4

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->close()V

    .line 121
    :cond_4
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->identificationEnd()V

    .line 125
    .end local v0    # "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    .end local v1    # "mIdentificationExtraExtra":Lcom/rokid/security/sdk/base/common/IdentificationExtra;
    :cond_5
    :goto_0
    return-void
.end method

.method public removeAiChatListener()V
    .locals 1

    .line 622
    const/4 v0, 0x0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mAiChatListener:Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    .line 623
    return-void
.end method

.method public setAiChatListener(Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 618
    sput-object p1, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mAiChatListener:Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    .line 619
    return-void
.end method

.method public final setMAiChatListener(Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    .line 50
    sput-object p1, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mAiChatListener:Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    return-void
.end method

.method public final setMOkHttpSSEClient(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    .line 48
    sput-object p1, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    return-void
.end method

.method public toChat(Ljava/lang/String;)V
    .locals 1
    .param p1, "question"    # Ljava/lang/String;

    const-string v0, "question"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 615
    return-void
.end method

.method public final toIdentification(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V
    .locals 28
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    const-string v0, "extra"

    move-object/from16 v11, p1

    invoke-static {v11, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 331
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->curAnswerContent:Ljava/lang/StringBuffer;

    .line 332
    new-instance v0, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v0}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    .local v0, "question":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getQuestion()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 333
    new-instance v1, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v12, v1

    .local v12, "imageUrl":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getImageUrl()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v12, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 334
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getImagePath()Ljava/lang/String;

    move-result-object v13

    .line 335
    .local v13, "imgPath":Ljava/lang/String;
    new-instance v1, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v14, v1

    .local v14, "identificationId":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getIdentificationId()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v14, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 337
    iget-object v1, v14, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 338
    sget-object v1, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v2, "toIdentification aborted: identificationId is blank"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 339
    invoke-direct/range {p0 .. p0}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->sendError()V

    .line 340
    return-void

    .line 344
    :cond_0
    new-instance v1, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v15, v1

    .local v15, "aiChatParam":Lkotlin/jvm/internal/Ref$ObjectRef;
    new-instance v1, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;

    invoke-direct {v1}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;-><init>()V

    iput-object v1, v15, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 345
    iget-object v1, v15, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;

    iget-object v2, v14, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;->setAppId(Ljava/lang/String;)V

    .line 346
    iget-object v1, v15, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    check-cast v2, Ljava/util/List;

    invoke-virtual {v1, v2}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;->setMessages(Ljava/util/List;)V

    .line 348
    new-instance v1, Lkotlin/jvm/internal/Ref$BooleanRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$BooleanRef;-><init>()V

    move-object v10, v1

    .line 349
    .local v10, "isModify":Lkotlin/jvm/internal/Ref$BooleanRef;
    new-instance v1, Lcom/rokid/security/phone/sdk/server/aichat/data/AiMessages;

    invoke-direct {v1}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiMessages;-><init>()V

    move-object v9, v1

    .line 350
    .local v9, "mAiMessages":Lcom/rokid/security/phone/sdk/server/aichat/data/AiMessages;
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    check-cast v1, Ljava/util/List;

    invoke-virtual {v9, v1}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiMessages;->setContents(Ljava/util/List;)V

    .line 351
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getQuestion()Ljava/lang/String;

    move-result-object v1

    const-string v2, ""

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    const/4 v3, 0x1

    if-nez v1, :cond_1

    .line 352
    sget-object v1, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "toIdentification-->)"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getQuestion()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v1, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 353
    iget-object v1, v15, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;

    invoke-virtual {v1, v3}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;->setUpdate(Z)V

    .line 354
    iput-boolean v3, v10, Lkotlin/jvm/internal/Ref$BooleanRef;->element:Z

    .line 355
    sget-object v1, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mAiChatListener:Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    .line 356
    .local v1, "aiChatListener":Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;
    if-eqz v1, :cond_2

    sget-object v4, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->questionId:Ljava/lang/String;

    invoke-interface {v1, v4}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onModify(Ljava/lang/String;)V

    goto :goto_0

    .line 358
    .end local v1    # "aiChatListener":Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;
    :cond_1
    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v4, "randomUUID().toString()"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sput-object v1, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->questionId:Ljava/lang/String;

    .line 360
    :cond_2
    :goto_0
    sget-object v7, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->questionId:Ljava/lang/String;

    .line 361
    .local v7, "requestQuestionId":Ljava/lang/String;
    new-instance v8, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v8, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    .line 363
    .local v8, "terminalHandled":Ljava/util/concurrent/atomic/AtomicBoolean;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "toIdentification-->"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v6, Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const/16 v6, 0x20

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v1, v12, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v5, " identificationId:"

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v5, v14, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v5, Ljava/lang/String;

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v5, v15, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v5, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;

    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;->getUpdate()Z

    move-result v5

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v5, " questionId:"

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v4, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 364
    new-instance v1, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;

    invoke-direct {v1}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;-><init>()V

    move-object v6, v1

    .line 365
    .local v6, "textAiContent":Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;
    iget-object v1, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    invoke-virtual {v6, v1}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;->setText(Ljava/lang/String;)V

    .line 366
    const-string/jumbo v1, "text"

    invoke-virtual {v6, v1}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;->setType(Ljava/lang/String;)V

    .line 369
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getImageBase64()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-lez v1, :cond_3

    goto :goto_1

    :cond_3
    const/4 v3, 0x0

    :goto_1
    if-eqz v3, :cond_8

    .line 370
    new-instance v1, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;

    invoke-direct {v1}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;-><init>()V

    .line 371
    .local v1, "imgAiContent":Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;
    const-string v3, "image_base64"

    invoke-virtual {v1, v3}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;->setType(Ljava/lang/String;)V

    .line 372
    const-string v3, "image/jpeg"

    invoke-virtual {v1, v3}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;->setMimeType(Ljava/lang/String;)V

    .line 373
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getImageBase64()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;->setData(Ljava/lang/String;)V

    .line 374
    invoke-virtual {v9}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiMessages;->getContents()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_4

    invoke-interface {v3, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 377
    :cond_4
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v3

    const-string v4, "receiver"

    invoke-virtual {v3, v4}, Landroid/app/Application;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v3

    .line 378
    .local v3, "appPrivateDir":Ljava/io/File;
    if-eqz v3, :cond_5

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v4

    if-nez v4, :cond_6

    .line 379
    :cond_5
    if-eqz v3, :cond_6

    invoke-virtual {v3}, Ljava/io/File;->mkdirs()Z

    .line 383
    :cond_6
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "image-"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v16, v13

    move-object/from16 v17, v14

    .end local v13    # "imgPath":Ljava/lang/String;
    .end local v14    # "identificationId":Lkotlin/jvm/internal/Ref$ObjectRef;
    .local v16, "imgPath":Ljava/lang/String;
    .local v17, "identificationId":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v13

    invoke-virtual {v4, v13, v14}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v13, "-aiPic.webp"

    invoke-virtual {v4, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 385
    .local v4, "fileName":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getAiImageType()Ljava/lang/String;

    move-result-object v13

    const-string v14, "jpg"

    invoke-static {v13, v14}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_7

    .line 386
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v13

    invoke-virtual {v5, v13, v14}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v13, "-aiPic.jpg"

    invoke-virtual {v5, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 389
    :cond_7
    new-instance v5, Ljava/io/File;

    invoke-direct {v5, v3, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 390
    .local v5, "outputFile":Ljava/io/File;
    sget-object v13, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;->getData()Ljava/lang/String;

    move-result-object v14

    move-object/from16 v18, v1

    .end local v1    # "imgAiContent":Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;
    .local v18, "imgAiContent":Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;
    invoke-virtual {v5}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    move-object/from16 v19, v3

    .end local v3    # "appPrivateDir":Ljava/io/File;
    .local v19, "appPrivateDir":Ljava/io/File;
    const-string v3, "outputFile.absolutePath"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v13, v14, v1}, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->base64ToImageFile(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    .line 391
    .local v1, "success":Z
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v3

    check-cast v3, Landroid/content/Context;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v14

    invoke-virtual {v14}, Landroid/app/Application;->getPackageName()Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, ".fileprovider"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-static {v3, v13, v5}, Landroidx/core/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object v3

    .line 392
    .local v3, "imageNativeUri":Landroid/net/Uri;
    invoke-virtual {v3}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v13

    const-string v14, "imageNativeUri.toString()"

    invoke-static {v13, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v24, 0x4

    const/16 v25, 0x0

    const-string v21, "content:"

    const-string v22, "https:"

    const/16 v23, 0x0

    move-object/from16 v20, v13

    invoke-static/range {v20 .. v25}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v13

    iput-object v13, v12, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 393
    sget-object v13, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v20, v3

    .end local v3    # "imageNativeUri":Landroid/net/Uri;
    .local v20, "imageNativeUri":Landroid/net/Uri;
    const-string/jumbo v3, "toIdentification imageUrl-->"

    invoke-virtual {v14, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v14, v12, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v14, Ljava/lang/String;

    invoke-virtual {v3, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v14, " success:"

    invoke-virtual {v3, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v14, " mFile:"

    invoke-virtual {v3, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v5}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v3, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v13, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_2

    .line 369
    .end local v1    # "success":Z
    .end local v4    # "fileName":Ljava/lang/String;
    .end local v5    # "outputFile":Ljava/io/File;
    .end local v16    # "imgPath":Ljava/lang/String;
    .end local v17    # "identificationId":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v18    # "imgAiContent":Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;
    .end local v19    # "appPrivateDir":Ljava/io/File;
    .end local v20    # "imageNativeUri":Landroid/net/Uri;
    .restart local v13    # "imgPath":Ljava/lang/String;
    .restart local v14    # "identificationId":Lkotlin/jvm/internal/Ref$ObjectRef;
    :cond_8
    move-object/from16 v16, v13

    move-object/from16 v17, v14

    .line 412
    .end local v13    # "imgPath":Ljava/lang/String;
    .end local v14    # "identificationId":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v16    # "imgPath":Ljava/lang/String;
    .restart local v17    # "identificationId":Lkotlin/jvm/internal/Ref$ObjectRef;
    :goto_2
    invoke-virtual {v9}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiMessages;->getContents()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_9

    invoke-interface {v1, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 413
    :cond_9
    iget-object v1, v15, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;->getMessages()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_a

    invoke-interface {v1, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 415
    :cond_a
    sget-object v13, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->mAiChatListener:Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;

    .line 416
    .local v13, "aiChatListener":Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;
    iget-boolean v1, v10, Lkotlin/jvm/internal/Ref$BooleanRef;->element:Z

    if-nez v1, :cond_b

    .line 417
    if-eqz v13, :cond_b

    iget-object v1, v12, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    invoke-interface {v13, v7, v2, v1}, Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;->onAIChatQuestion(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 421
    :cond_b
    sget-object v1, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->TAG:Ljava/lang/String;

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

    .line 422
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v18

    new-instance v14, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;

    const/16 v19, 0x0

    move-object v1, v14

    move-object v2, v15

    move-object/from16 v3, v17

    move-object v4, v0

    move-object/from16 v5, p1

    move-object/from16 v24, v6

    .end local v6    # "textAiContent":Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;
    .local v24, "textAiContent":Lcom/rokid/security/phone/sdk/server/aichat/data/AiContent;
    move-object v6, v7

    move-object/from16 v25, v7

    .end local v7    # "requestQuestionId":Ljava/lang/String;
    .local v25, "requestQuestionId":Ljava/lang/String;
    move-object v7, v10

    move-object/from16 v26, v9

    .end local v9    # "mAiMessages":Lcom/rokid/security/phone/sdk/server/aichat/data/AiMessages;
    .local v26, "mAiMessages":Lcom/rokid/security/phone/sdk/server/aichat/data/AiMessages;
    move-object v9, v12

    move-object/from16 v27, v10

    .end local v10    # "isModify":Lkotlin/jvm/internal/Ref$BooleanRef;
    .local v27, "isModify":Lkotlin/jvm/internal/Ref$BooleanRef;
    move-object/from16 v10, v19

    invoke-direct/range {v1 .. v10}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/sdk/base/common/IdentificationExtra;Ljava/lang/String;Lkotlin/jvm/internal/Ref$BooleanRef;Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/coroutines/Continuation;)V

    move-object/from16 v21, v14

    check-cast v21, Lkotlin/jvm/functions/Function2;

    const/16 v22, 0x3

    const/16 v23, 0x0

    const/16 v20, 0x0

    invoke-static/range {v18 .. v23}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 479
    return-void
.end method
