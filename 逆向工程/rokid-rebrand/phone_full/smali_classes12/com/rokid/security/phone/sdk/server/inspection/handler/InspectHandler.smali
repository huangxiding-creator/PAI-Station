.class public final Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;
.super Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;
.source "InspectHandler.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000.\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0008\n\u0002\u0010 \n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\n\u0018\u0000 \u001c2\u00020\u0001:\u0001\u001cB\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J\u000e\u0010\u000e\u001a\u0008\u0012\u0004\u0012\u00020\u00060\u000fH\u0016J\u0010\u0010\u0010\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\u0013H\u0002J\u0010\u0010\u0014\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\u0013H\u0016J\u0010\u0010\u0015\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\u0013H\u0002J\u0010\u0010\u0016\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\u0013H\u0002J\u0010\u0010\u0017\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\u0013H\u0002J\u0010\u0010\u0018\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\u0013H\u0002J\u0010\u0010\u0019\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\u0013H\u0002J\u0010\u0010\u001a\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\u0013H\u0002J\u0010\u0010\u001b\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\u0013H\u0002R\u001c\u0010\u0005\u001a\u0004\u0018\u00010\u0006X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0007\u0010\u0008\"\u0004\u0008\t\u0010\nR\u001c\u0010\u000b\u001a\u0004\u0018\u00010\u0006X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000c\u0010\u0008\"\u0004\u0008\r\u0010\n\u00a8\u0006\u001d"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;",
        "Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;",
        "serviceImpl",
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;",
        "(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V",
        "ossUrl",
        "",
        "getOssUrl",
        "()Ljava/lang/String;",
        "setOssUrl",
        "(Ljava/lang/String;)V",
        "videoFilePath",
        "getVideoFilePath",
        "setVideoFilePath",
        "getSupportedMethods",
        "",
        "handleInspectHeartbeat",
        "",
        "aiChatExtra",
        "Lcom/rokid/security/sdk/base/common/AiChatExtra;",
        "handleMessage",
        "handleOfflineTaskBegin",
        "handleOfflineTaskEnd",
        "handleQRCodeRec",
        "handleTakePicture",
        "handleToAIChat",
        "handleToInspect",
        "handleToInspectEnd",
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
.field public static final Companion:Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler$Companion;

.field private static final TAG:Ljava/lang/String; = "InspectHandler"


# instance fields
.field private ossUrl:Ljava/lang/String;

.field private videoFilePath:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->Companion:Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler$Companion;

    return-void
.end method

.method public constructor <init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V
    .locals 1
    .param p1, "serviceImpl"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    const-string/jumbo v0, "serviceImpl"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 13
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V

    .line 47
    nop

    .line 49
    nop

    .line 13
    return-void
.end method

.method private final handleInspectHeartbeat(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 2
    .param p1, "aiChatExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 105
    const-string v0, "InspectHandler"

    const-string/jumbo v1, "\u5904\u7406\u5de1\u68c0\u5fc3\u8df3"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 106
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->getServiceImpl()Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->onHeartbeat(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    .line 107
    return-void
.end method

.method private final handleOfflineTaskBegin(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 4
    .param p1, "aiChatExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 115
    const-string v0, "InspectHandler"

    const-string/jumbo v1, "\u79bb\u7ebf\u6a21\u5f0f\u8bf7\u6c42task begin"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 116
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->getServiceImpl()Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    move-result-object v0

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getOfflineTaskID()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getSessionId()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x1

    invoke-virtual {v0, v1, v2, v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineTaskStartAction(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 117
    return-void
.end method

.method private final handleOfflineTaskEnd(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 2
    .param p1, "aiChatExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 120
    const-string v0, "InspectHandler"

    const-string/jumbo v1, "\u79bb\u7ebf\u6a21\u5f0f\u8bf7\u6c42task end"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 121
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->getServiceImpl()Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    move-result-object v0

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getOfflineTaskID()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineTaskEndAction(Ljava/lang/String;)V

    .line 122
    return-void
.end method

.method private final handleQRCodeRec(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 1
    .param p1, "aiChatExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 125
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->getServiceImpl()Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->startQRcodeRec()V

    .line 126
    return-void
.end method

.method private final handleTakePicture(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 2
    .param p1, "aiChatExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 110
    const-string v0, "InspectHandler"

    const-string/jumbo v1, "\u5904\u7406\u5f00\u59cb\u62cd\u7167\u8bf7\u6c42"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 111
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->getServiceImpl()Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->toTakePicture(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    .line 112
    return-void
.end method

.method private final handleToAIChat(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 1
    .param p1, "aiChatExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 129
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->getServiceImpl()Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->toGuideAiChat(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    .line 130
    return-void
.end method

.method private final handleToInspect(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 2
    .param p1, "aiChatExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 100
    const-string v0, "InspectHandler"

    const-string/jumbo v1, "\u5904\u7406\u5f00\u59cb\u5de1\u68c0\u8bf7\u6c42"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 101
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->getServiceImpl()Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->toInspect(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    .line 102
    return-void
.end method

.method private final handleToInspectEnd(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 2
    .param p1, "aiChatExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 138
    const-string v0, "InspectHandler"

    const-string/jumbo v1, "\u5904\u7406\u5de1\u68c0\u7ed3\u675f\u8bf7\u6c42"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 140
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getVideoFileMD5()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, ""

    :cond_0
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->videoFilePath:Ljava/lang/String;

    .line 142
    return-void
.end method


# virtual methods
.method public final getOssUrl()Ljava/lang/String;
    .locals 1

    .line 133
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->ossUrl:Ljava/lang/String;

    return-object v0
.end method

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

    .line 87
    const/4 v0, 0x6

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "ToInspect"

    aput-object v2, v0, v1

    .line 88
    const-string v1, "InspectHeartbeat"

    const/4 v2, 0x1

    aput-object v1, v0, v2

    .line 87
    nop

    .line 89
    const-string v1, "TakePicture"

    const/4 v2, 0x2

    aput-object v1, v0, v2

    .line 87
    nop

    .line 90
    const-string v1, "OfflineTaskBegin"

    const/4 v2, 0x3

    aput-object v1, v0, v2

    .line 87
    nop

    .line 91
    const-string v1, "OfflineTaskEnd"

    const/4 v2, 0x4

    aput-object v1, v0, v2

    .line 87
    nop

    .line 92
    const-string v1, "QRCodeRec"

    const/4 v2, 0x5

    aput-object v1, v0, v2

    .line 87
    nop

    .line 86
    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public final getVideoFilePath()Ljava/lang/String;
    .locals 1

    .line 132
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->videoFilePath:Ljava/lang/String;

    return-object v0
.end method

.method public handleMessage(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 2
    .param p1, "aiChatExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    const-string v0, "aiChatExtra"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 58
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v1

    sparse-switch v1, :sswitch_data_0

    :goto_0
    goto :goto_1

    :sswitch_0
    const-string v1, "OfflineTaskBegin"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 73
    :cond_0
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->handleOfflineTaskBegin(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    goto :goto_1

    .line 58
    :sswitch_1
    const-string v1, "QRCodeRec"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    .line 80
    :cond_1
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->handleQRCodeRec(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    goto :goto_1

    .line 58
    :sswitch_2
    const-string v1, "TakePicture"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    goto :goto_0

    .line 69
    :cond_2
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->handleTakePicture(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    goto :goto_1

    .line 58
    :sswitch_3
    const-string v1, "InspectHeartbeat"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    goto :goto_0

    .line 63
    :cond_3
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->handleInspectHeartbeat(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    goto :goto_1

    .line 58
    :sswitch_4
    const-string v1, "ToInspect"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    goto :goto_0

    .line 60
    :cond_4
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->handleToInspect(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    goto :goto_1

    .line 58
    :sswitch_5
    const-string v1, "OfflineTaskEnd"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    goto :goto_0

    .line 77
    :cond_5
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->handleOfflineTaskEnd(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    .line 83
    :goto_1
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        -0x78214e2d -> :sswitch_5
        -0x77042507 -> :sswitch_4
        -0x6ef17698 -> :sswitch_3
        -0x5fe76da9 -> :sswitch_2
        -0x34dcb9fe -> :sswitch_1
        0xacb43a1 -> :sswitch_0
    .end sparse-switch
.end method

.method public final setOssUrl(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 133
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->ossUrl:Ljava/lang/String;

    return-void
.end method

.method public final setVideoFilePath(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 132
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;->videoFilePath:Ljava/lang/String;

    return-void
.end method
