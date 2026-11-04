.class public final Lcom/rokid/security/sdk/base/common/AsrExtra;
.super Ljava/lang/Object;
.source "AsrExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000$\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0010\u000b\n\u0002\u0008\u0005\n\u0002\u0010\u0008\n\u0002\u0008\u000e\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000eR\u001a\u0010\u000f\u001a\u00020\u0010X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0011\u0010\u0012\"\u0004\u0008\u0013\u0010\u0014R\u001a\u0010\u0015\u001a\u00020\u0010X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0016\u0010\u0012\"\u0004\u0008\u0017\u0010\u0014R\u001a\u0010\u0018\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0019\u0010\u0006\"\u0004\u0008\u001a\u0010\u0008R\u001a\u0010\u001b\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001c\u0010\u0006\"\u0004\u0008\u001d\u0010\u0008\u00a8\u0006\u001e"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/AsrExtra;",
        "",
        "()V",
        "asrContent",
        "",
        "getAsrContent",
        "()Ljava/lang/String;",
        "setAsrContent",
        "(Ljava/lang/String;)V",
        "connectState",
        "",
        "getConnectState",
        "()Z",
        "setConnectState",
        "(Z)V",
        "errCode",
        "",
        "getErrCode",
        "()I",
        "setErrCode",
        "(I)V",
        "intent",
        "getIntent",
        "setIntent",
        "intentAction",
        "getIntentAction",
        "setIntentAction",
        "methodName",
        "getMethodName",
        "setMethodName",
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
.field private asrContent:Ljava/lang/String;

.field private connectState:Z

.field private errCode:I

.field private intent:I

.field private intentAction:Ljava/lang/String;

.field private methodName:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 22
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/AsrExtra;->methodName:Ljava/lang/String;

    .line 24
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/AsrExtra;->asrContent:Ljava/lang/String;

    .line 28
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/AsrExtra;->intentAction:Ljava/lang/String;

    .line 19
    return-void
.end method


# virtual methods
.method public final getAsrContent()Ljava/lang/String;
    .locals 1

    .line 24
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AsrExtra;->asrContent:Ljava/lang/String;

    return-object v0
.end method

.method public final getConnectState()Z
    .locals 1

    .line 32
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/AsrExtra;->connectState:Z

    return v0
.end method

.method public final getErrCode()I
    .locals 1

    .line 30
    iget v0, p0, Lcom/rokid/security/sdk/base/common/AsrExtra;->errCode:I

    return v0
.end method

.method public final getIntent()I
    .locals 1

    .line 26
    iget v0, p0, Lcom/rokid/security/sdk/base/common/AsrExtra;->intent:I

    return v0
.end method

.method public final getIntentAction()Ljava/lang/String;
    .locals 1

    .line 28
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AsrExtra;->intentAction:Ljava/lang/String;

    return-object v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 22
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AsrExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final setAsrContent(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AsrExtra;->asrContent:Ljava/lang/String;

    return-void
.end method

.method public final setConnectState(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 32
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/AsrExtra;->connectState:Z

    return-void
.end method

.method public final setErrCode(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 30
    iput p1, p0, Lcom/rokid/security/sdk/base/common/AsrExtra;->errCode:I

    return-void
.end method

.method public final setIntent(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 26
    iput p1, p0, Lcom/rokid/security/sdk/base/common/AsrExtra;->intent:I

    return-void
.end method

.method public final setIntentAction(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 28
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AsrExtra;->intentAction:Ljava/lang/String;

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 22
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AsrExtra;->methodName:Ljava/lang/String;

    return-void
.end method
