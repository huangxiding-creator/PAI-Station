.class public final Lcom/rokid/security/phone/sdk/server/inspection/handler/SessionHandler;
.super Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;
.source "SessionHandler.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/server/inspection/handler/SessionHandler$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010 \n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0018\u0000 \r2\u00020\u0001:\u0001\rB\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J\u000e\u0010\u0005\u001a\u0008\u0012\u0004\u0012\u00020\u00070\u0006H\u0016J\u0010\u0010\u0008\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\u000bH\u0016J\u0008\u0010\u000c\u001a\u00020\tH\u0002\u00a8\u0006\u000e"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/inspection/handler/SessionHandler;",
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
        "handleResetSessionId",
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
.field public static final Companion:Lcom/rokid/security/phone/sdk/server/inspection/handler/SessionHandler$Companion;

.field private static final TAG:Ljava/lang/String; = "SessionHandler"


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/handler/SessionHandler$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/handler/SessionHandler$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/handler/SessionHandler;->Companion:Lcom/rokid/security/phone/sdk/server/inspection/handler/SessionHandler$Companion;

    return-void
.end method

.method public constructor <init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V
    .locals 1
    .param p1, "serviceImpl"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    const-string/jumbo v0, "serviceImpl"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 14
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V

    return-void
.end method

.method private final handleResetSessionId()V
    .locals 3

    .line 38
    const-string/jumbo v0, "\u5904\u7406\u91cd\u7f6eSessionId\u8bf7\u6c42"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "SessionHandler"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 41
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/SessionHandler;->getServiceImpl()Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    move-result-object v0

    const-string v2, "default"

    invoke-virtual {v0, v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->setGuideSessionId(Ljava/lang/String;)V

    .line 42
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "\u91cd\u7f6eSessionId: audioSessionId="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/SessionHandler;->getServiceImpl()Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    move-result-object v2

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->getGuideSessionId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ", guideSessionId="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/SessionHandler;->getServiceImpl()Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    move-result-object v2

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->getGuideSessionId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 44
    return-void
.end method


# virtual methods
.method public getSupportedMethods()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 30
    nop

    .line 29
    const-string v0, "ResetSessionId"

    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public handleMessage(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 2
    .param p1, "aiChatExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    const-string v0, "aiChatExtra"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 21
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v0

    .line 22
    const-string v1, "ResetSessionId"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 23
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/SessionHandler;->handleResetSessionId()V

    .line 26
    :cond_0
    return-void
.end method
