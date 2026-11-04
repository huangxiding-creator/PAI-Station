.class public final Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;
.super Ljava/lang/Object;
.source "OfflineRecExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000$\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0010\u000b\n\u0002\u0008\u0007\n\u0002\u0018\u0002\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\t\u0010\u000b\"\u0004\u0008\u000c\u0010\rR\u001a\u0010\u000e\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000f\u0010\u0006\"\u0004\u0008\u0010\u0010\u0008R\u001c\u0010\u0011\u001a\u0004\u0018\u00010\u0012X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u0014\"\u0004\u0008\u0015\u0010\u0016\u00a8\u0006\u0017"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;",
        "",
        "()V",
        "extraType",
        "",
        "getExtraType",
        "()Ljava/lang/String;",
        "setExtraType",
        "(Ljava/lang/String;)V",
        "isSuccess",
        "",
        "()Z",
        "setSuccess",
        "(Z)V",
        "methodName",
        "getMethodName",
        "setMethodName",
        "personnelInfo",
        "Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;",
        "getPersonnelInfo",
        "()Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;",
        "setPersonnelInfo",
        "(Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;)V",
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
.field private extraType:Ljava/lang/String;

.field private isSuccess:Z

.field private methodName:Ljava/lang/String;

.field private personnelInfo:Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    const-string v0, "RequestPersonInfoResponse"

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;->extraType:Ljava/lang/String;

    .line 43
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;->methodName:Ljava/lang/String;

    .line 41
    return-void
.end method


# virtual methods
.method public final getExtraType()Ljava/lang/String;
    .locals 1

    .line 42
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;->extraType:Ljava/lang/String;

    return-object v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 43
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getPersonnelInfo()Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;
    .locals 1

    .line 45
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;->personnelInfo:Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;

    return-object v0
.end method

.method public final isSuccess()Z
    .locals 1

    .line 44
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;->isSuccess:Z

    return v0
.end method

.method public final setExtraType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;->extraType:Ljava/lang/String;

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 43
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setPersonnelInfo(Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;

    .line 45
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;->personnelInfo:Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;

    return-void
.end method

.method public final setSuccess(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 44
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;->isSuccess:Z

    return-void
.end method
