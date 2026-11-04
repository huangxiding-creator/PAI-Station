.class public final Lcom/rokid/security/sdk/base/common/aichat/AiMessage;
.super Ljava/lang/Object;
.source "Choice.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\"\u0010\u0003\u001a\n\u0012\u0004\u0012\u00020\u0005\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0006\u0010\u0007\"\u0004\u0008\u0008\u0010\tR\u001a\u0010\n\u001a\u00020\u000bX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000c\u0010\r\"\u0004\u0008\u000e\u0010\u000fR&\u0010\u0010\u001a\n\u0012\u0004\u0012\u00020\u0011\u0018\u00010\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0012\u0010\u0007\"\u0004\u0008\u0013\u0010\t\u00a8\u0006\u0014"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/aichat/AiMessage;",
        "",
        "()V",
        "contents",
        "",
        "Lcom/rokid/security/sdk/base/common/aichat/AiContent;",
        "getContents",
        "()Ljava/util/List;",
        "setContents",
        "(Ljava/util/List;)V",
        "role",
        "",
        "getRole",
        "()Ljava/lang/String;",
        "setRole",
        "(Ljava/lang/String;)V",
        "toolCalls",
        "Lcom/rokid/security/sdk/base/common/aichat/ToolCall;",
        "getToolCalls",
        "setToolCalls",
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
.field private contents:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/aichat/AiContent;",
            ">;"
        }
    .end annotation
.end field

.field private role:Ljava/lang/String;

.field private toolCalls:Ljava/util/List;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "tool_calls"
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/aichat/ToolCall;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 28
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->role:Ljava/lang/String;

    .line 25
    return-void
.end method


# virtual methods
.method public final getContents()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/aichat/AiContent;",
            ">;"
        }
    .end annotation

    .line 29
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->contents:Ljava/util/List;

    return-object v0
.end method

.method public final getRole()Ljava/lang/String;
    .locals 1

    .line 28
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->role:Ljava/lang/String;

    return-object v0
.end method

.method public final getToolCalls()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/aichat/ToolCall;",
            ">;"
        }
    .end annotation

    .line 31
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->toolCalls:Ljava/util/List;

    return-object v0
.end method

.method public final setContents(Ljava/util/List;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/aichat/AiContent;",
            ">;)V"
        }
    .end annotation

    .line 29
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->contents:Ljava/util/List;

    return-void
.end method

.method public final setRole(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 28
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->role:Ljava/lang/String;

    return-void
.end method

.method public final setToolCalls(Ljava/util/List;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/aichat/ToolCall;",
            ">;)V"
        }
    .end annotation

    .line 31
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->toolCalls:Ljava/util/List;

    return-void
.end method
