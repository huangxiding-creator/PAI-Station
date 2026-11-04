.class public final Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;
.super Ljava/lang/Object;
.source "Choice.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0007\n\u0002\u0010\t\n\u0002\u0008\r\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u0014\u0010\u0003\u001a\u00020\u0004X\u0086D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006R\u0014\u0010\u0007\u001a\u00020\u0004X\u0086D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0008\u0010\u0006R\u0014\u0010\t\u001a\u00020\u0004X\u0086D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\n\u0010\u0006R\u0014\u0010\u000b\u001a\u00020\u000cX\u0086D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\r\u0010\u000eR\u0014\u0010\u000f\u001a\u00020\u0004X\u0086D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0010\u0010\u0006R\u0014\u0010\u0011\u001a\u00020\u0004X\u0086D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0012\u0010\u0006R\u0014\u0010\u0013\u001a\u00020\u0004X\u0086D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0014\u0010\u0006R\u001a\u0010\u0015\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0016\u0010\u0006\"\u0004\u0008\u0017\u0010\u0018\u00a8\u0006\u0019"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;",
        "",
        "()V",
        "action",
        "",
        "getAction",
        "()Ljava/lang/String;",
        "content",
        "getContent",
        "data",
        "getData",
        "delay",
        "",
        "getDelay",
        "()J",
        "text",
        "getText",
        "tips",
        "getTips",
        "title",
        "getTitle",
        "type",
        "getType",
        "setType",
        "(Ljava/lang/String;)V",
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
.field private final action:Ljava/lang/String;

.field private final content:Ljava/lang/String;

.field private final data:Ljava/lang/String;

.field private final delay:J

.field private final text:Ljava/lang/String;

.field private final tips:Ljava/lang/String;

.field private final title:Ljava/lang/String;

.field private type:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 70
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 71
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->type:Ljava/lang/String;

    .line 73
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->content:Ljava/lang/String;

    .line 74
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->tips:Ljava/lang/String;

    .line 75
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->title:Ljava/lang/String;

    .line 76
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->action:Ljava/lang/String;

    .line 77
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->text:Ljava/lang/String;

    .line 78
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->data:Ljava/lang/String;

    .line 70
    return-void
.end method


# virtual methods
.method public final getAction()Ljava/lang/String;
    .locals 1

    .line 76
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->action:Ljava/lang/String;

    return-object v0
.end method

.method public final getContent()Ljava/lang/String;
    .locals 1

    .line 73
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->content:Ljava/lang/String;

    return-object v0
.end method

.method public final getData()Ljava/lang/String;
    .locals 1

    .line 78
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->data:Ljava/lang/String;

    return-object v0
.end method

.method public final getDelay()J
    .locals 2

    .line 72
    iget-wide v0, p0, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->delay:J

    return-wide v0
.end method

.method public final getText()Ljava/lang/String;
    .locals 1

    .line 77
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->text:Ljava/lang/String;

    return-object v0
.end method

.method public final getTips()Ljava/lang/String;
    .locals 1

    .line 74
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->tips:Ljava/lang/String;

    return-object v0
.end method

.method public final getTitle()Ljava/lang/String;
    .locals 1

    .line 75
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->title:Ljava/lang/String;

    return-object v0
.end method

.method public final getType()Ljava/lang/String;
    .locals 1

    .line 71
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->type:Ljava/lang/String;

    return-object v0
.end method

.method public final setType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 71
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->type:Ljava/lang/String;

    return-void
.end method
