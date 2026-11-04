.class public final Lcom/rokid/security/sdk/base/common/TtsExtra;
.super Ljava/lang/Object;
.source "TtsExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000,\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0010\u0008\n\u0002\u0008\r\n\u0002\u0010\t\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000eR\u001a\u0010\u000f\u001a\u00020\u0010X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0011\u0010\u0012\"\u0004\u0008\u0013\u0010\u0014R\u001a\u0010\u0015\u001a\u00020\u0010X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0016\u0010\u0012\"\u0004\u0008\u0017\u0010\u0014R\u001a\u0010\u0018\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0018\u0010\u0006\"\u0004\u0008\u0019\u0010\u0008R\u001a\u0010\u001a\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001b\u0010\u000c\"\u0004\u0008\u001c\u0010\u000eR\u001a\u0010\u001d\u001a\u00020\u001eX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001f\u0010 \"\u0004\u0008!\u0010\"\u00a8\u0006#"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/TtsExtra;",
        "",
        "()V",
        "connectState",
        "",
        "getConnectState",
        "()Z",
        "setConnectState",
        "(Z)V",
        "content",
        "",
        "getContent",
        "()Ljava/lang/String;",
        "setContent",
        "(Ljava/lang/String;)V",
        "errorCode",
        "",
        "getErrorCode",
        "()I",
        "setErrorCode",
        "(I)V",
        "id",
        "getId",
        "setId",
        "isEnd",
        "setEnd",
        "methodName",
        "getMethodName",
        "setMethodName",
        "sessionId",
        "",
        "getSessionId",
        "()J",
        "setSessionId",
        "(J)V",
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
.field private connectState:Z

.field private content:Ljava/lang/String;

.field private errorCode:I

.field private id:I

.field private isEnd:Z

.field private methodName:Ljava/lang/String;

.field private sessionId:J


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 15
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/TtsExtra;->methodName:Ljava/lang/String;

    .line 17
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/TtsExtra;->content:Ljava/lang/String;

    .line 13
    return-void
.end method


# virtual methods
.method public final getConnectState()Z
    .locals 1

    .line 27
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/TtsExtra;->connectState:Z

    return v0
.end method

.method public final getContent()Ljava/lang/String;
    .locals 1

    .line 17
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/TtsExtra;->content:Ljava/lang/String;

    return-object v0
.end method

.method public final getErrorCode()I
    .locals 1

    .line 25
    iget v0, p0, Lcom/rokid/security/sdk/base/common/TtsExtra;->errorCode:I

    return v0
.end method

.method public final getId()I
    .locals 1

    .line 19
    iget v0, p0, Lcom/rokid/security/sdk/base/common/TtsExtra;->id:I

    return v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 15
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/TtsExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getSessionId()J
    .locals 2

    .line 21
    iget-wide v0, p0, Lcom/rokid/security/sdk/base/common/TtsExtra;->sessionId:J

    return-wide v0
.end method

.method public final isEnd()Z
    .locals 1

    .line 23
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/TtsExtra;->isEnd:Z

    return v0
.end method

.method public final setConnectState(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 27
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/TtsExtra;->connectState:Z

    return-void
.end method

.method public final setContent(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 17
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/TtsExtra;->content:Ljava/lang/String;

    return-void
.end method

.method public final setEnd(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 23
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/TtsExtra;->isEnd:Z

    return-void
.end method

.method public final setErrorCode(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 25
    iput p1, p0, Lcom/rokid/security/sdk/base/common/TtsExtra;->errorCode:I

    return-void
.end method

.method public final setId(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 19
    iput p1, p0, Lcom/rokid/security/sdk/base/common/TtsExtra;->id:I

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 15
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/TtsExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setSessionId(J)V
    .locals 0
    .param p1, "<set-?>"    # J

    .line 21
    iput-wide p1, p0, Lcom/rokid/security/sdk/base/common/TtsExtra;->sessionId:J

    return-void
.end method
