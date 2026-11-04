.class public final Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;
.super Ljava/lang/Object;
.source "OfflineRecExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000 \n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u000e\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\"\u0010\t\u001a\n\u0012\u0004\u0012\u00020\u000b\u0018\u00010\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000c\u0010\r\"\u0004\u0008\u000e\u0010\u000fR\u001a\u0010\u0010\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0011\u0010\u0006\"\u0004\u0008\u0012\u0010\u0008R\u001a\u0010\u0013\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0014\u0010\u0006\"\u0004\u0008\u0015\u0010\u0008R\u001a\u0010\u0016\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0017\u0010\u0006\"\u0004\u0008\u0018\u0010\u0008\u00a8\u0006\u0019"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;",
        "",
        "()V",
        "extraType",
        "",
        "getExtraType",
        "()Ljava/lang/String;",
        "setExtraType",
        "(Ljava/lang/String;)V",
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
.field private extraType:Ljava/lang/String;

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
    .locals 1

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    const-string v0, "CheckUpdate"

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->extraType:Ljava/lang/String;

    .line 17
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->methodName:Ljava/lang/String;

    .line 18
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->sceneId:Ljava/lang/String;

    .line 19
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->sn:Ljava/lang/String;

    .line 15
    return-void
.end method


# virtual methods
.method public final getExtraType()Ljava/lang/String;
    .locals 1

    .line 16
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->extraType:Ljava/lang/String;

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

    .line 20
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->libList:Ljava/util/List;

    return-object v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 17
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getSceneId()Ljava/lang/String;
    .locals 1

    .line 18
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->sceneId:Ljava/lang/String;

    return-object v0
.end method

.method public final getSn()Ljava/lang/String;
    .locals 1

    .line 19
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->sn:Ljava/lang/String;

    return-object v0
.end method

.method public final setExtraType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 16
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->extraType:Ljava/lang/String;

    return-void
.end method

.method public final setLibList(Ljava/util/List;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
            ">;)V"
        }
    .end annotation

    .line 20
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->libList:Ljava/util/List;

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 17
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setSceneId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 18
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->sceneId:Ljava/lang/String;

    return-void
.end method

.method public final setSn(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->sn:Ljava/lang/String;

    return-void
.end method
