.class public abstract Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;
.super Ljava/lang/Object;
.source "MessageHandler.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00000\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010 \n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\u0008&\u0018\u00002\u00020\u0001B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J\u000e\u0010\u0007\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\nJ\u000e\u0010\u000b\u001a\u0008\u0012\u0004\u0012\u00020\n0\u000cH&J\u0010\u0010\r\u001a\u00020\u000e2\u0006\u0010\u000f\u001a\u00020\u0010H&R\u0014\u0010\u0002\u001a\u00020\u0003X\u0084\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\u00a8\u0006\u0011"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;",
        "",
        "serviceImpl",
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;",
        "(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V",
        "getServiceImpl",
        "()Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;",
        "canHandle",
        "",
        "methodName",
        "",
        "getSupportedMethods",
        "",
        "handleMessage",
        "",
        "aiChatExtra",
        "Lcom/rokid/security/sdk/base/common/AiChatExtra;",
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
.field private final serviceImpl:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;


# direct methods
.method public constructor <init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V
    .locals 1
    .param p1, "serviceImpl"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    const-string/jumbo v0, "serviceImpl"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;->serviceImpl:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    return-void
.end method


# virtual methods
.method public final canHandle(Ljava/lang/String;)Z
    .locals 1
    .param p1, "methodName"    # Ljava/lang/String;

    const-string v0, "methodName"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 31
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;->getSupportedMethods()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method protected final getServiceImpl()Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;
    .locals 1

    .line 11
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;->serviceImpl:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    return-object v0
.end method

.method public abstract getSupportedMethods()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end method

.method public abstract handleMessage(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
.end method
