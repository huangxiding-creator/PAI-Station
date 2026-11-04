.class public final Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$toGuideAiChat$1$1;
.super Ljava/lang/Object;
.source "InspectionServiceImpl.kt"

# interfaces
.implements Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$toGuideAiChat$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000!\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u0003\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0008\u0010\u0002\u001a\u00020\u0003H\u0016J\u0008\u0010\u0004\u001a\u00020\u0003H\u0016J\u0008\u0010\u0005\u001a\u00020\u0003H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u0008H\u0016J\u0010\u0010\t\u001a\u00020\u00032\u0006\u0010\n\u001a\u00020\u000bH\u0016\u00a8\u0006\u000c"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$toGuideAiChat$1$1",
        "Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;",
        "onClosed",
        "",
        "onComplete",
        "onConnected",
        "onError",
        "t",
        "",
        "onMessage",
        "data",
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


# direct methods
.method constructor <init>()V
    .locals 0

    .line 781
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClosed()V
    .locals 3

    .line 804
    const-string v0, "InspectionServiceImpl"

    const-string v1, "onClosed"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 805
    new-instance v0, Lcom/rokid/security/sdk/base/common/aichat/AiContent;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;-><init>()V

    .line 806
    .local v0, "endContent":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    sget-object v1, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->GUIDE:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->setContentType(Lcom/rokid/security/sdk/base/common/aichat/AiContentType;)V

    .line 807
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    const/4 v2, 0x1

    invoke-static {v1, v0, v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$sendChatContent(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V

    .line 808
    return-void
.end method

.method public onComplete()V
    .locals 3

    .line 792
    const-string v0, "InspectionServiceImpl"

    const-string v1, "guide onComplete"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 793
    new-instance v0, Lcom/rokid/security/sdk/base/common/aichat/AiContent;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;-><init>()V

    .line 794
    .local v0, "endContent":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    sget-object v1, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->GUIDE:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->setContentType(Lcom/rokid/security/sdk/base/common/aichat/AiContentType;)V

    .line 795
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    const/4 v2, 0x1

    invoke-static {v1, v0, v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$sendChatContent(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V

    .line 796
    return-void
.end method

.method public onConnected()V
    .locals 2

    .line 783
    const-string v0, "InspectionServiceImpl"

    const-string v1, "onConnected"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 784
    return-void
.end method

.method public onError(Ljava/lang/Throwable;)V
    .locals 2
    .param p1, "t"    # Ljava/lang/Throwable;

    const-string/jumbo v0, "t"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 799
    const-string v0, "InspectionServiceImpl"

    const-string v1, "onError"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 800
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$sendError(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V

    .line 801
    return-void
.end method

.method public onMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/String;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 788
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-static {v0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$handleInspectGuideMessage(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;Ljava/lang/String;)V

    .line 789
    return-void
.end method
