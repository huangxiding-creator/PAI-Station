.class public final Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;
.super Ljava/lang/Object;
.source "LauncherRootBean.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0008\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u000b\n\u0002\u0008\u0007\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\"\u0010\u000c\u001a\n\u0012\u0004\u0012\u00020\u000e\u0018\u00010\rX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000f\u0010\u0010\"\u0004\u0008\u0011\u0010\u0012R\u001a\u0010\u0013\u001a\u00020\u0014X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u0015\"\u0004\u0008\u0016\u0010\u0017R\u001a\u0010\u0018\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0019\u0010\u0006\"\u0004\u0008\u001a\u0010\u0008\u00a8\u0006\u001b"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;",
        "",
        "()V",
        "appCode",
        "",
        "getAppCode",
        "()Ljava/lang/String;",
        "setAppCode",
        "(Ljava/lang/String;)V",
        "appName",
        "getAppName",
        "setAppName",
        "apps",
        "",
        "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;",
        "getApps",
        "()Ljava/util/List;",
        "setApps",
        "(Ljava/util/List;)V",
        "isHide",
        "",
        "()Z",
        "setHide",
        "(Z)V",
        "launcherIcon",
        "getLauncherIcon",
        "setLauncherIcon",
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
.field private appCode:Ljava/lang/String;

.field private appName:Ljava/lang/String;

.field private apps:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;",
            ">;"
        }
    .end annotation
.end field

.field private isHide:Z

.field private launcherIcon:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;->appCode:Ljava/lang/String;

    .line 20
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;->appName:Ljava/lang/String;

    .line 21
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;->launcherIcon:Ljava/lang/String;

    .line 22
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;->isHide:Z

    .line 18
    return-void
.end method


# virtual methods
.method public final getAppCode()Ljava/lang/String;
    .locals 1

    .line 19
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;->appCode:Ljava/lang/String;

    return-object v0
.end method

.method public final getAppName()Ljava/lang/String;
    .locals 1

    .line 20
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;->appName:Ljava/lang/String;

    return-object v0
.end method

.method public final getApps()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;",
            ">;"
        }
    .end annotation

    .line 23
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;->apps:Ljava/util/List;

    return-object v0
.end method

.method public final getLauncherIcon()Ljava/lang/String;
    .locals 1

    .line 21
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;->launcherIcon:Ljava/lang/String;

    return-object v0
.end method

.method public final isHide()Z
    .locals 1

    .line 22
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;->isHide:Z

    return v0
.end method

.method public final setAppCode(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;->appCode:Ljava/lang/String;

    return-void
.end method

.method public final setAppName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 20
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;->appName:Ljava/lang/String;

    return-void
.end method

.method public final setApps(Ljava/util/List;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/AppItemBean;",
            ">;)V"
        }
    .end annotation

    .line 23
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;->apps:Ljava/util/List;

    return-void
.end method

.method public final setHide(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 22
    iput-boolean p1, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;->isHide:Z

    return-void
.end method

.method public final setLauncherIcon(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 21
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;->launcherIcon:Ljava/lang/String;

    return-void
.end method
