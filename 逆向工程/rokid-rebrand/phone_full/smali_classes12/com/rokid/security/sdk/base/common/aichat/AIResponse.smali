.class public final Lcom/rokid/security/sdk/base/common/aichat/AIResponse;
.super Ljava/lang/Object;
.source "Choice.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000,\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001c\u0010\u0003\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001c\u0010\t\u001a\u0004\u0018\u00010\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000eR \u0010\u000f\u001a\u0004\u0018\u00010\u00108\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0011\u0010\u0012\"\u0004\u0008\u0013\u0010\u0014R\u001c\u0010\u0015\u001a\u0004\u0018\u00010\u0016X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0017\u0010\u0018\"\u0004\u0008\u0019\u0010\u001a\u00a8\u0006\u001b"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/aichat/AIResponse;",
        "",
        "()V",
        "message",
        "Lcom/rokid/security/sdk/base/common/aichat/AiMessage;",
        "getMessage",
        "()Lcom/rokid/security/sdk/base/common/aichat/AiMessage;",
        "setMessage",
        "(Lcom/rokid/security/sdk/base/common/aichat/AiMessage;)V",
        "metadata",
        "Lcom/rokid/security/sdk/base/common/aichat/Metadata;",
        "getMetadata",
        "()Lcom/rokid/security/sdk/base/common/aichat/Metadata;",
        "setMetadata",
        "(Lcom/rokid/security/sdk/base/common/aichat/Metadata;)V",
        "outputMetadata",
        "Lcom/rokid/security/sdk/base/common/aichat/OutputMetadata;",
        "getOutputMetadata",
        "()Lcom/rokid/security/sdk/base/common/aichat/OutputMetadata;",
        "setOutputMetadata",
        "(Lcom/rokid/security/sdk/base/common/aichat/OutputMetadata;)V",
        "sessionId",
        "",
        "getSessionId",
        "()Ljava/lang/String;",
        "setSessionId",
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
.field private message:Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

.field private metadata:Lcom/rokid/security/sdk/base/common/aichat/Metadata;

.field private outputMetadata:Lcom/rokid/security/sdk/base/common/aichat/OutputMetadata;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "outputMetadata"
    .end annotation
.end field

.field private sessionId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getMessage()Lcom/rokid/security/sdk/base/common/aichat/AiMessage;
    .locals 1

    .line 15
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->message:Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

    return-object v0
.end method

.method public final getMetadata()Lcom/rokid/security/sdk/base/common/aichat/Metadata;
    .locals 1

    .line 16
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->metadata:Lcom/rokid/security/sdk/base/common/aichat/Metadata;

    return-object v0
.end method

.method public final getOutputMetadata()Lcom/rokid/security/sdk/base/common/aichat/OutputMetadata;
    .locals 1

    .line 19
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->outputMetadata:Lcom/rokid/security/sdk/base/common/aichat/OutputMetadata;

    return-object v0
.end method

.method public final getSessionId()Ljava/lang/String;
    .locals 1

    .line 17
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->sessionId:Ljava/lang/String;

    return-object v0
.end method

.method public final setMessage(Lcom/rokid/security/sdk/base/common/aichat/AiMessage;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

    .line 15
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->message:Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

    return-void
.end method

.method public final setMetadata(Lcom/rokid/security/sdk/base/common/aichat/Metadata;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/aichat/Metadata;

    .line 16
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->metadata:Lcom/rokid/security/sdk/base/common/aichat/Metadata;

    return-void
.end method

.method public final setOutputMetadata(Lcom/rokid/security/sdk/base/common/aichat/OutputMetadata;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/aichat/OutputMetadata;

    .line 19
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->outputMetadata:Lcom/rokid/security/sdk/base/common/aichat/OutputMetadata;

    return-void
.end method

.method public final setSessionId(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 17
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->sessionId:Ljava/lang/String;

    return-void
.end method
