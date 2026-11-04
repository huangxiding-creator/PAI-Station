.class public final Lcom/rokid/security/sdk/base/common/RequestCertResponseExtra;
.super Ljava/lang/Object;
.source "CertExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000,\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0008\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0010\u000b\n\u0002\u0008\u0007\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001c\u0010\u0003\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000eR\u001a\u0010\u000f\u001a\u00020\u0010X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0011\u0010\u0012\"\u0004\u0008\u0013\u0010\u0014R\u001a\u0010\u0015\u001a\u00020\u0016X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0015\u0010\u0017\"\u0004\u0008\u0018\u0010\u0019R\u001a\u0010\u001a\u001a\u00020\u0010X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001b\u0010\u0012\"\u0004\u0008\u001c\u0010\u0014\u00a8\u0006\u001d"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/RequestCertResponseExtra;",
        "",
        "()V",
        "certMakeResult",
        "Lcom/rokid/security/sdk/base/common/out/CertMakeResult;",
        "getCertMakeResult",
        "()Lcom/rokid/security/sdk/base/common/out/CertMakeResult;",
        "setCertMakeResult",
        "(Lcom/rokid/security/sdk/base/common/out/CertMakeResult;)V",
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
.field private certMakeResult:Lcom/rokid/security/sdk/base/common/out/CertMakeResult;

.field private errorCode:I

.field private errorMsg:Ljava/lang/String;

.field private isSuccess:Z

.field private methodName:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestCertResponseExtra;->methodName:Ljava/lang/String;

    .line 39
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestCertResponseExtra;->errorMsg:Ljava/lang/String;

    .line 35
    return-void
.end method


# virtual methods
.method public final getCertMakeResult()Lcom/rokid/security/sdk/base/common/out/CertMakeResult;
    .locals 1

    .line 38
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestCertResponseExtra;->certMakeResult:Lcom/rokid/security/sdk/base/common/out/CertMakeResult;

    return-object v0
.end method

.method public final getErrorCode()I
    .locals 1

    .line 40
    iget v0, p0, Lcom/rokid/security/sdk/base/common/RequestCertResponseExtra;->errorCode:I

    return v0
.end method

.method public final getErrorMsg()Ljava/lang/String;
    .locals 1

    .line 39
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestCertResponseExtra;->errorMsg:Ljava/lang/String;

    return-object v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 36
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestCertResponseExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final isSuccess()Z
    .locals 1

    .line 37
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/RequestCertResponseExtra;->isSuccess:Z

    return v0
.end method

.method public final setCertMakeResult(Lcom/rokid/security/sdk/base/common/out/CertMakeResult;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/out/CertMakeResult;

    .line 38
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/RequestCertResponseExtra;->certMakeResult:Lcom/rokid/security/sdk/base/common/out/CertMakeResult;

    return-void
.end method

.method public final setErrorCode(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 40
    iput p1, p0, Lcom/rokid/security/sdk/base/common/RequestCertResponseExtra;->errorCode:I

    return-void
.end method

.method public final setErrorMsg(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 39
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/RequestCertResponseExtra;->errorMsg:Ljava/lang/String;

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 36
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/RequestCertResponseExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setSuccess(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 37
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/RequestCertResponseExtra;->isSuccess:Z

    return-void
.end method
