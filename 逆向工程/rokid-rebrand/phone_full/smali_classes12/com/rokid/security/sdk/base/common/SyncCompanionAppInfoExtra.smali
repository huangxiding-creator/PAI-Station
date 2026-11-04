.class public final Lcom/rokid/security/sdk/base/common/SyncCompanionAppInfoExtra;
.super Ljava/lang/Object;
.source "ToolsExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0002\u0008\u0008\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001c\u0010\u0003\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000eR\u001a\u0010\u000f\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u000c\"\u0004\u0008\u0011\u0010\u000e\u00a8\u0006\u0012"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/SyncCompanionAppInfoExtra;",
        "",
        "()V",
        "companionAppInfo",
        "Lcom/rokid/security/sdk/base/common/outside/CompanionAppInfo;",
        "getCompanionAppInfo",
        "()Lcom/rokid/security/sdk/base/common/outside/CompanionAppInfo;",
        "setCompanionAppInfo",
        "(Lcom/rokid/security/sdk/base/common/outside/CompanionAppInfo;)V",
        "extraType",
        "",
        "getExtraType",
        "()Ljava/lang/String;",
        "setExtraType",
        "(Ljava/lang/String;)V",
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
.field private companionAppInfo:Lcom/rokid/security/sdk/base/common/outside/CompanionAppInfo;

.field private extraType:Ljava/lang/String;

.field private methodName:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 25
    const-string v0, "SYNC_CompanionAppInfo"

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/SyncCompanionAppInfoExtra;->extraType:Ljava/lang/String;

    .line 26
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/SyncCompanionAppInfoExtra;->methodName:Ljava/lang/String;

    .line 24
    return-void
.end method


# virtual methods
.method public final getCompanionAppInfo()Lcom/rokid/security/sdk/base/common/outside/CompanionAppInfo;
    .locals 1

    .line 27
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SyncCompanionAppInfoExtra;->companionAppInfo:Lcom/rokid/security/sdk/base/common/outside/CompanionAppInfo;

    return-object v0
.end method

.method public final getExtraType()Ljava/lang/String;
    .locals 1

    .line 25
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SyncCompanionAppInfoExtra;->extraType:Ljava/lang/String;

    return-object v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 26
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SyncCompanionAppInfoExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final setCompanionAppInfo(Lcom/rokid/security/sdk/base/common/outside/CompanionAppInfo;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/outside/CompanionAppInfo;

    .line 27
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SyncCompanionAppInfoExtra;->companionAppInfo:Lcom/rokid/security/sdk/base/common/outside/CompanionAppInfo;

    return-void
.end method

.method public final setExtraType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SyncCompanionAppInfoExtra;->extraType:Ljava/lang/String;

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 26
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SyncCompanionAppInfoExtra;->methodName:Ljava/lang/String;

    return-void
.end method
