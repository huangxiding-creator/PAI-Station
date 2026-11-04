.class public final Lcom/rokid/security/sdk/base/common/auth/CredentialResp;
.super Ljava/lang/Object;
.source "Credential.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000$\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0008\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001c\u0010\u0003\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000eR\u001a\u0010\u000f\u001a\u00020\u0010X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0011\u0010\u0012\"\u0004\u0008\u0013\u0010\u0014\u00a8\u0006\u0015"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/auth/CredentialResp;",
        "",
        "()V",
        "data",
        "Lcom/rokid/security/sdk/base/common/auth/AuthToken;",
        "getData",
        "()Lcom/rokid/security/sdk/base/common/auth/AuthToken;",
        "setData",
        "(Lcom/rokid/security/sdk/base/common/auth/AuthToken;)V",
        "errCode",
        "",
        "getErrCode",
        "()I",
        "setErrCode",
        "(I)V",
        "errMsg",
        "",
        "getErrMsg",
        "()Ljava/lang/String;",
        "setErrMsg",
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
.field private data:Lcom/rokid/security/sdk/base/common/auth/AuthToken;

.field private errCode:I

.field private errMsg:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 10
    const/4 v0, -0x1

    iput v0, p0, Lcom/rokid/security/sdk/base/common/auth/CredentialResp;->errCode:I

    .line 11
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/auth/CredentialResp;->errMsg:Ljava/lang/String;

    .line 7
    return-void
.end method


# virtual methods
.method public final getData()Lcom/rokid/security/sdk/base/common/auth/AuthToken;
    .locals 1

    .line 12
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/auth/CredentialResp;->data:Lcom/rokid/security/sdk/base/common/auth/AuthToken;

    return-object v0
.end method

.method public final getErrCode()I
    .locals 1

    .line 10
    iget v0, p0, Lcom/rokid/security/sdk/base/common/auth/CredentialResp;->errCode:I

    return v0
.end method

.method public final getErrMsg()Ljava/lang/String;
    .locals 1

    .line 11
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/auth/CredentialResp;->errMsg:Ljava/lang/String;

    return-object v0
.end method

.method public final setData(Lcom/rokid/security/sdk/base/common/auth/AuthToken;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/auth/AuthToken;

    .line 12
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/auth/CredentialResp;->data:Lcom/rokid/security/sdk/base/common/auth/AuthToken;

    return-void
.end method

.method public final setErrCode(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 10
    iput p1, p0, Lcom/rokid/security/sdk/base/common/auth/CredentialResp;->errCode:I

    return-void
.end method

.method public final setErrMsg(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 11
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/auth/CredentialResp;->errMsg:Ljava/lang/String;

    return-void
.end method
