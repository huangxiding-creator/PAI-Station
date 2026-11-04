.class public final Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;
.super Ljava/lang/Object;
.source "CertExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u000b\n\u0002\u0010\u000b\n\u0002\u0008\u0016\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001c\u0010\u0003\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001c\u0010\t\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001a\u0010\u000c\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u0006\"\u0004\u0008\u000e\u0010\u0008R\u001a\u0010\u000f\u001a\u00020\u0010X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000f\u0010\u0011\"\u0004\u0008\u0012\u0010\u0013R\u001c\u0010\u0014\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0015\u0010\u0006\"\u0004\u0008\u0016\u0010\u0008R\u001a\u0010\u0017\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0018\u0010\u0006\"\u0004\u0008\u0019\u0010\u0008R\u001c\u0010\u001a\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001b\u0010\u0006\"\u0004\u0008\u001c\u0010\u0008R\u001c\u0010\u001d\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001e\u0010\u0006\"\u0004\u0008\u001f\u0010\u0008R\u001c\u0010 \u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008!\u0010\u0006\"\u0004\u0008\"\u0010\u0008R\u001c\u0010#\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008$\u0010\u0006\"\u0004\u0008%\u0010\u0008\u00a8\u0006&"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;",
        "",
        "()V",
        "alias",
        "",
        "getAlias",
        "()Ljava/lang/String;",
        "setAlias",
        "(Ljava/lang/String;)V",
        "base64EncCert",
        "getBase64EncCert",
        "setBase64EncCert",
        "errorMsg",
        "getErrorMsg",
        "setErrorMsg",
        "isSuccess",
        "",
        "()Z",
        "setSuccess",
        "(Z)V",
        "issuer",
        "getIssuer",
        "setIssuer",
        "methodName",
        "getMethodName",
        "setMethodName",
        "notAfter",
        "getNotAfter",
        "setNotAfter",
        "notBefore",
        "getNotBefore",
        "setNotBefore",
        "serialNumber",
        "getSerialNumber",
        "setSerialNumber",
        "subject",
        "getSubject",
        "setSubject",
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
.field private alias:Ljava/lang/String;

.field private base64EncCert:Ljava/lang/String;

.field private errorMsg:Ljava/lang/String;

.field private isSuccess:Z

.field private issuer:Ljava/lang/String;

.field private methodName:Ljava/lang/String;

.field private notAfter:Ljava/lang/String;

.field private notBefore:Ljava/lang/String;

.field private serialNumber:Ljava/lang/String;

.field private subject:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 48
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->methodName:Ljava/lang/String;

    .line 51
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->errorMsg:Ljava/lang/String;

    .line 47
    return-void
.end method


# virtual methods
.method public final getAlias()Ljava/lang/String;
    .locals 1

    .line 52
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->alias:Ljava/lang/String;

    return-object v0
.end method

.method public final getBase64EncCert()Ljava/lang/String;
    .locals 1

    .line 50
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->base64EncCert:Ljava/lang/String;

    return-object v0
.end method

.method public final getErrorMsg()Ljava/lang/String;
    .locals 1

    .line 51
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->errorMsg:Ljava/lang/String;

    return-object v0
.end method

.method public final getIssuer()Ljava/lang/String;
    .locals 1

    .line 55
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->issuer:Ljava/lang/String;

    return-object v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 48
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getNotAfter()Ljava/lang/String;
    .locals 1

    .line 57
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->notAfter:Ljava/lang/String;

    return-object v0
.end method

.method public final getNotBefore()Ljava/lang/String;
    .locals 1

    .line 56
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->notBefore:Ljava/lang/String;

    return-object v0
.end method

.method public final getSerialNumber()Ljava/lang/String;
    .locals 1

    .line 54
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->serialNumber:Ljava/lang/String;

    return-object v0
.end method

.method public final getSubject()Ljava/lang/String;
    .locals 1

    .line 53
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->subject:Ljava/lang/String;

    return-object v0
.end method

.method public final isSuccess()Z
    .locals 1

    .line 49
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->isSuccess:Z

    return v0
.end method

.method public final setAlias(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 52
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->alias:Ljava/lang/String;

    return-void
.end method

.method public final setBase64EncCert(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 50
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->base64EncCert:Ljava/lang/String;

    return-void
.end method

.method public final setErrorMsg(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 51
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->errorMsg:Ljava/lang/String;

    return-void
.end method

.method public final setIssuer(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 55
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->issuer:Ljava/lang/String;

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 48
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setNotAfter(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 57
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->notAfter:Ljava/lang/String;

    return-void
.end method

.method public final setNotBefore(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 56
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->notBefore:Ljava/lang/String;

    return-void
.end method

.method public final setSerialNumber(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 54
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->serialNumber:Ljava/lang/String;

    return-void
.end method

.method public final setSubject(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 53
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->subject:Ljava/lang/String;

    return-void
.end method

.method public final setSuccess(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 49
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->isSuccess:Z

    return-void
.end method
