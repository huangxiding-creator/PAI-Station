.class public final Lcom/rokid/security/sdk/base/common/aichat/ToolCall;
.super Ljava/lang/Object;
.source "Choice.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000$\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0002\u0008\u0008\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R \u0010\u0003\u001a\u0004\u0018\u00010\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001c\u0010\t\u001a\u0004\u0018\u00010\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000eR\u001a\u0010\u000f\u001a\u00020\u0010X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0011\u0010\u0012\"\u0004\u0008\u0013\u0010\u0014R\u001a\u0010\u0015\u001a\u00020\u0010X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0016\u0010\u0012\"\u0004\u0008\u0017\u0010\u0014\u00a8\u0006\u0018"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/aichat/ToolCall;",
        "",
        "()V",
        "extBody",
        "Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;",
        "getExtBody",
        "()Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;",
        "setExtBody",
        "(Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;)V",
        "function",
        "Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;",
        "getFunction",
        "()Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;",
        "setFunction",
        "(Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;)V",
        "id",
        "",
        "getId",
        "()Ljava/lang/String;",
        "setId",
        "(Ljava/lang/String;)V",
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
.field private extBody:Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "ext_body"
    .end annotation
.end field

.field private function:Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;

.field private id:Ljava/lang/String;

.field private type:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 151
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 152
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->id:Ljava/lang/String;

    .line 153
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->type:Ljava/lang/String;

    .line 151
    return-void
.end method


# virtual methods
.method public final getExtBody()Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;
    .locals 1

    .line 156
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->extBody:Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;

    return-object v0
.end method

.method public final getFunction()Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;
    .locals 1

    .line 154
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->function:Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;

    return-object v0
.end method

.method public final getId()Ljava/lang/String;
    .locals 1

    .line 152
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->id:Ljava/lang/String;

    return-object v0
.end method

.method public final getType()Ljava/lang/String;
    .locals 1

    .line 153
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->type:Ljava/lang/String;

    return-object v0
.end method

.method public final setExtBody(Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;

    .line 156
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->extBody:Lcom/rokid/security/sdk/base/common/aichat/ToolExtBody;

    return-void
.end method

.method public final setFunction(Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;

    .line 154
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->function:Lcom/rokid/security/sdk/base/common/aichat/ToolFunction;

    return-void
.end method

.method public final setId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 152
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->id:Ljava/lang/String;

    return-void
.end method

.method public final setType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 153
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/ToolCall;->type:Ljava/lang/String;

    return-void
.end method
