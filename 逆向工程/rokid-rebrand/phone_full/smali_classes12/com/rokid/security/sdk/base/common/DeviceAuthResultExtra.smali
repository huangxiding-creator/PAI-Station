.class public final Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;
.super Ljava/lang/Object;
.source "DeviceAuthExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000$\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0010\u000b\n\u0002\u0008\u0007\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000eR\u001a\u0010\u000f\u001a\u00020\u0010X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000f\u0010\u0011\"\u0004\u0008\u0012\u0010\u0013R\u001a\u0010\u0014\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0015\u0010\u000c\"\u0004\u0008\u0016\u0010\u000e\u00a8\u0006\u0017"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;",
        "",
        "()V",
        "errorCode",
        "",
        "getErrorCode",
        "()I",
        "setErrorCode",
        "(I)V",
        "errorMsg",
        "",
        "getErrorMsg",
        "()Ljava/lang/String;",
        "setErrorMsg",
        "(Ljava/lang/String;)V",
        "isSuccess",
        "",
        "()Z",
        "setSuccess",
        "(Z)V",
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
.field private errorCode:I

.field private errorMsg:Ljava/lang/String;

.field private isSuccess:Z

.field private methodName:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 58
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 59
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;->methodName:Ljava/lang/String;

    .line 61
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;->errorMsg:Ljava/lang/String;

    .line 58
    return-void
.end method


# virtual methods
.method public final getErrorCode()I
    .locals 1

    .line 62
    iget v0, p0, Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;->errorCode:I

    return v0
.end method

.method public final getErrorMsg()Ljava/lang/String;
    .locals 1

    .line 61
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;->errorMsg:Ljava/lang/String;

    return-object v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 59
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final isSuccess()Z
    .locals 1

    .line 60
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;->isSuccess:Z

    return v0
.end method

.method public final setErrorCode(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 62
    iput p1, p0, Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;->errorCode:I

    return-void
.end method

.method public final setErrorMsg(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 61
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;->errorMsg:Ljava/lang/String;

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 59
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setSuccess(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 60
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;->isSuccess:Z

    return-void
.end method
