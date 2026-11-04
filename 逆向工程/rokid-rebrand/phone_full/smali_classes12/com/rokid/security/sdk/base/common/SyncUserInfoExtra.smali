.class public final Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;
.super Ljava/lang/Object;
.source "ToolsExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0008\n\u0002\u0018\u0002\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001c\u0010\u000c\u001a\u0004\u0018\u00010\rX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000e\u0010\u000f\"\u0004\u0008\u0010\u0010\u0011\u00a8\u0006\u0012"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;",
        "",
        "()V",
        "extraType",
        "",
        "getExtraType",
        "()Ljava/lang/String;",
        "setExtraType",
        "(Ljava/lang/String;)V",
        "methodName",
        "getMethodName",
        "setMethodName",
        "userInfo",
        "Lcom/rokid/security/sdk/base/common/outside/UserInfo;",
        "getUserInfo",
        "()Lcom/rokid/security/sdk/base/common/outside/UserInfo;",
        "setUserInfo",
        "(Lcom/rokid/security/sdk/base/common/outside/UserInfo;)V",
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

.field private methodName:Ljava/lang/String;

.field private userInfo:Lcom/rokid/security/sdk/base/common/outside/UserInfo;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    const-string v0, "SYNC_USERINFO"

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;->extraType:Ljava/lang/String;

    .line 20
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;->methodName:Ljava/lang/String;

    .line 18
    return-void
.end method


# virtual methods
.method public final getExtraType()Ljava/lang/String;
    .locals 1

    .line 19
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;->extraType:Ljava/lang/String;

    return-object v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 20
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getUserInfo()Lcom/rokid/security/sdk/base/common/outside/UserInfo;
    .locals 1

    .line 21
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;->userInfo:Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    return-object v0
.end method

.method public final setExtraType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;->extraType:Ljava/lang/String;

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 20
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setUserInfo(Lcom/rokid/security/sdk/base/common/outside/UserInfo;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    .line 21
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;->userInfo:Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    return-void
.end method
