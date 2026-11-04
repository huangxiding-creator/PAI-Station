.class public final Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;
.super Ljava/lang/Object;
.source "LauncherRootBean.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000$\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u000b\n\u0002\u0010\u000b\n\u0002\u0008\u0007\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001c\u0010\t\u001a\u0004\u0018\u00010\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000eR\u001a\u0010\u000f\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u0006\"\u0004\u0008\u0011\u0010\u0008R\u001a\u0010\u0012\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u0006\"\u0004\u0008\u0014\u0010\u0008R\u001a\u0010\u0015\u001a\u00020\u0016X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0015\u0010\u0017\"\u0004\u0008\u0018\u0010\u0019R\u001a\u0010\u001a\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001b\u0010\u0006\"\u0004\u0008\u001c\u0010\u0008\u00a8\u0006\u001d"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;",
        "",
        "()V",
        "agentId",
        "",
        "getAgentId",
        "()Ljava/lang/String;",
        "setAgentId",
        "(Ljava/lang/String;)V",
        "extConfig",
        "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/ExtConfig;",
        "getExtConfig",
        "()Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/ExtConfig;",
        "setExtConfig",
        "(Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/ExtConfig;)V",
        "icon",
        "getIcon",
        "setIcon",
        "id",
        "getId",
        "setId",
        "isDefault",
        "",
        "()Z",
        "setDefault",
        "(Z)V",
        "name",
        "getName",
        "setName",
        "sdk-api_release"
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
.field private agentId:Ljava/lang/String;

.field private extConfig:Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/ExtConfig;

.field private icon:Ljava/lang/String;

.field private id:Ljava/lang/String;

.field private isDefault:Z

.field private name:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;->id:Ljava/lang/String;

    .line 33
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;->name:Ljava/lang/String;

    .line 34
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;->icon:Ljava/lang/String;

    .line 35
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;->agentId:Ljava/lang/String;

    .line 31
    return-void
.end method


# virtual methods
.method public final getAgentId()Ljava/lang/String;
    .locals 1

    .line 35
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;->agentId:Ljava/lang/String;

    return-object v0
.end method

.method public final getExtConfig()Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/ExtConfig;
    .locals 1

    .line 37
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;->extConfig:Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/ExtConfig;

    return-object v0
.end method

.method public final getIcon()Ljava/lang/String;
    .locals 1

    .line 34
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;->icon:Ljava/lang/String;

    return-object v0
.end method

.method public final getId()Ljava/lang/String;
    .locals 1

    .line 32
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;->id:Ljava/lang/String;

    return-object v0
.end method

.method public final getName()Ljava/lang/String;
    .locals 1

    .line 33
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;->name:Ljava/lang/String;

    return-object v0
.end method

.method public final isDefault()Z
    .locals 1

    .line 36
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;->isDefault:Z

    return v0
.end method

.method public final setAgentId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 35
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;->agentId:Ljava/lang/String;

    return-void
.end method

.method public final setDefault(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 36
    iput-boolean p1, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;->isDefault:Z

    return-void
.end method

.method public final setExtConfig(Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/ExtConfig;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/ExtConfig;

    .line 37
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;->extConfig:Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/ExtConfig;

    return-void
.end method

.method public final setIcon(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 34
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;->icon:Ljava/lang/String;

    return-void
.end method

.method public final setId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 32
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;->id:Ljava/lang/String;

    return-void
.end method

.method public final setName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 33
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;->name:Ljava/lang/String;

    return-void
.end method
