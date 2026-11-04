.class public final Lcom/rokid/security/phone/sdk/server/aichat/handler/ChatHandler;
.super Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;
.source "ChatHandler.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/server/aichat/handler/ChatHandler$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010 \n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\u0018\u0000 \u000f2\u00020\u0001:\u0001\u000fB\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J\u000e\u0010\u0005\u001a\u0008\u0012\u0004\u0012\u00020\u00070\u0006H\u0016J\u0010\u0010\u0008\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\u000bH\u0016J\u0008\u0010\u000c\u001a\u00020\tH\u0002J\u0010\u0010\r\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\u000bH\u0002J\u0010\u0010\u000e\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\u000bH\u0002\u00a8\u0006\u0010"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/aichat/handler/ChatHandler;",
        "Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;",
        "serviceImpl",
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;",
        "(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V",
        "getSupportedMethods",
        "",
        "",
        "handleMessage",
        "",
        "aiChatExtra",
        "Lcom/rokid/security/sdk/base/common/AiChatExtra;",
        "handleStopAiChat",
        "handleToAiChat",
        "handleToCode",
        "Companion",
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
.field public static final Companion:Lcom/rokid/security/phone/sdk/server/aichat/handler/ChatHandler$Companion;

.field private static final TAG:Ljava/lang/String; = "ChatHandler"


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/aichat/handler/ChatHandler$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/server/aichat/handler/ChatHandler$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/aichat/handler/ChatHandler;->Companion:Lcom/rokid/security/phone/sdk/server/aichat/handler/ChatHandler$Companion;

    return-void
.end method

.method public constructor <init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V
    .locals 1
    .param p1, "serviceImpl"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    const-string/jumbo v0, "serviceImpl"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 17
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V

    return-void
.end method

.method private final handleStopAiChat()V
    .locals 2

    .line 64
    const-string/jumbo v0, "\u5904\u7406\u505c\u6b62AI\u804a\u5929\u8bf7\u6c42"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ChatHandler"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 66
    return-void
.end method

.method private final handleToAiChat(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 2
    .param p1, "aiChatExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 47
    const-string/jumbo v0, "\u5904\u7406AI\u804a\u5929\u8bf7\u6c42"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ChatHandler"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 49
    return-void
.end method

.method private final handleToCode(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 2
    .param p1, "aiChatExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 55
    const-string/jumbo v0, "\u5904\u7406\u4ee3\u7801\u751f\u6210\u8bf7\u6c42"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ChatHandler"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 58
    return-void
.end method


# virtual methods
.method public getSupportedMethods()Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 37
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string/jumbo v2, "toAiChat"

    aput-object v2, v0, v1

    .line 38
    const-string/jumbo v1, "stopAiChat"

    const/4 v2, 0x1

    aput-object v1, v0, v2

    .line 37
    nop

    .line 36
    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public handleMessage(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 2
    .param p1, "aiChatExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    const-string v0, "aiChatExtra"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v0

    .line 26
    const-string/jumbo v1, "toAiChat"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 27
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/aichat/handler/ChatHandler;->handleToAiChat(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    goto :goto_0

    .line 29
    :cond_0
    const-string/jumbo v1, "stopAiChat"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 30
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/aichat/handler/ChatHandler;->handleStopAiChat()V

    .line 33
    :cond_1
    :goto_0
    return-void
.end method
