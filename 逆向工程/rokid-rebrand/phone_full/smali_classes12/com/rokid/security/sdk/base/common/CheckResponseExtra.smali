.class public final Lcom/rokid/security/sdk/base/common/CheckResponseExtra;
.super Ljava/lang/Object;
.source "OfflineRecExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00000\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0002\u0008\u0008\n\u0002\u0010\u000b\n\u0002\u0008\u0004\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u000e\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000eR\u001a\u0010\u000f\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u000c\"\u0004\u0008\u0011\u0010\u000eR\u001a\u0010\u0012\u001a\u00020\u0013X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0012\u0010\u0014\"\u0004\u0008\u0015\u0010\u0016R \u0010\u0017\u001a\u0008\u0012\u0004\u0012\u00020\u00190\u0018X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001a\u0010\u001b\"\u0004\u0008\u001c\u0010\u001dR\u001a\u0010\u001e\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001f\u0010\u000c\"\u0004\u0008 \u0010\u000eR\u001a\u0010!\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\"\u0010\u000c\"\u0004\u0008#\u0010\u000eR\u001a\u0010$\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008%\u0010\u000c\"\u0004\u0008&\u0010\u000e\u00a8\u0006\'"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/CheckResponseExtra;",
        "",
        "()V",
        "errorCode",
        "",
        "getErrorCode",
        "()I",
        "setErrorCode",
        "(I)V",
        "errorMessage",
        "",
        "getErrorMessage",
        "()Ljava/lang/String;",
        "setErrorMessage",
        "(Ljava/lang/String;)V",
        "extraType",
        "getExtraType",
        "setExtraType",
        "isSuccess",
        "",
        "()Z",
        "setSuccess",
        "(Z)V",
        "libList",
        "",
        "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
        "getLibList",
        "()Ljava/util/List;",
        "setLibList",
        "(Ljava/util/List;)V",
        "methodName",
        "getMethodName",
        "setMethodName",
        "sceneId",
        "getSceneId",
        "setSceneId",
        "sn",
        "getSn",
        "setSn",
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

.field private errorMessage:Ljava/lang/String;

.field private extraType:Ljava/lang/String;

.field private isSuccess:Z

.field private libList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
            ">;"
        }
    .end annotation
.end field

.field private methodName:Ljava/lang/String;

.field private sceneId:Ljava/lang/String;

.field private sn:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    const-string v0, "CheckResponse"

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->extraType:Ljava/lang/String;

    .line 25
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->methodName:Ljava/lang/String;

    .line 26
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->sceneId:Ljava/lang/String;

    .line 27
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->sn:Ljava/lang/String;

    .line 30
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    check-cast v1, Ljava/util/List;

    iput-object v1, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->libList:Ljava/util/List;

    .line 32
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->errorMessage:Ljava/lang/String;

    .line 23
    return-void
.end method


# virtual methods
.method public final getErrorCode()I
    .locals 1

    .line 31
    iget v0, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->errorCode:I

    return v0
.end method

.method public final getErrorMessage()Ljava/lang/String;
    .locals 1

    .line 32
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->errorMessage:Ljava/lang/String;

    return-object v0
.end method

.method public final getExtraType()Ljava/lang/String;
    .locals 1

    .line 24
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->extraType:Ljava/lang/String;

    return-object v0
.end method

.method public final getLibList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
            ">;"
        }
    .end annotation

    .line 30
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->libList:Ljava/util/List;

    return-object v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 25
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getSceneId()Ljava/lang/String;
    .locals 1

    .line 26
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->sceneId:Ljava/lang/String;

    return-object v0
.end method

.method public final getSn()Ljava/lang/String;
    .locals 1

    .line 27
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->sn:Ljava/lang/String;

    return-object v0
.end method

.method public final isSuccess()Z
    .locals 1

    .line 29
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->isSuccess:Z

    return v0
.end method

.method public final setErrorCode(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 31
    iput p1, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->errorCode:I

    return-void
.end method

.method public final setErrorMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 32
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->errorMessage:Ljava/lang/String;

    return-void
.end method

.method public final setExtraType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->extraType:Ljava/lang/String;

    return-void
.end method

.method public final setLibList(Ljava/util/List;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
            ">;)V"
        }
    .end annotation

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 30
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->libList:Ljava/util/List;

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setSceneId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 26
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->sceneId:Ljava/lang/String;

    return-void
.end method

.method public final setSn(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 27
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->sn:Ljava/lang/String;

    return-void
.end method

.method public final setSuccess(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 29
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->isSuccess:Z

    return-void
.end method
