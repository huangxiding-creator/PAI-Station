.class public final Lcom/rokid/security/sdk/base/common/aichat/AiContent;
.super Ljava/lang/Object;
.source "Choice.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0002\u0008\u000b\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001c\u0010\t\u001a\u0004\u0018\u00010\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000eR\u001a\u0010\u000f\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u000c\"\u0004\u0008\u0011\u0010\u000eR\u001a\u0010\u0012\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u000c\"\u0004\u0008\u0014\u0010\u000e\u00a8\u0006\u0015"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/aichat/AiContent;",
        "",
        "()V",
        "contentType",
        "Lcom/rokid/security/sdk/base/common/aichat/AiContentType;",
        "getContentType",
        "()Lcom/rokid/security/sdk/base/common/aichat/AiContentType;",
        "setContentType",
        "(Lcom/rokid/security/sdk/base/common/aichat/AiContentType;)V",
        "sessionId",
        "",
        "getSessionId",
        "()Ljava/lang/String;",
        "setSessionId",
        "(Ljava/lang/String;)V",
        "text",
        "getText",
        "setText",
        "type",
        "getType",
        "setType",
        "sdk-base-common_release"
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
.field private contentType:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

.field private sessionId:Ljava/lang/String;

.field private text:Ljava/lang/String;

.field private type:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 38
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->text:Ljava/lang/String;

    .line 39
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->type:Ljava/lang/String;

    .line 41
    sget-object v0, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->AUDIO:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->contentType:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    .line 35
    return-void
.end method


# virtual methods
.method public final getContentType()Lcom/rokid/security/sdk/base/common/aichat/AiContentType;
    .locals 1

    .line 41
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->contentType:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    return-object v0
.end method

.method public final getSessionId()Ljava/lang/String;
    .locals 1

    .line 40
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->sessionId:Ljava/lang/String;

    return-object v0
.end method

.method public final getText()Ljava/lang/String;
    .locals 1

    .line 38
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->text:Ljava/lang/String;

    return-object v0
.end method

.method public final getType()Ljava/lang/String;
    .locals 1

    .line 39
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->type:Ljava/lang/String;

    return-object v0
.end method

.method public final setContentType(Lcom/rokid/security/sdk/base/common/aichat/AiContentType;)V
    .locals 1
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 41
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->contentType:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    return-void
.end method

.method public final setSessionId(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 40
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->sessionId:Ljava/lang/String;

    return-void
.end method

.method public final setText(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 38
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->text:Ljava/lang/String;

    return-void
.end method

.method public final setType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 39
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->type:Ljava/lang/String;

    return-void
.end method
