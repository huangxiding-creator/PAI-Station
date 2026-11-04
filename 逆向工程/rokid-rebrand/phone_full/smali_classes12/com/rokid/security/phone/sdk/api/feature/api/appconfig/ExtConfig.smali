.class public final Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/ExtConfig;
.super Ljava/lang/Object;
.source "LauncherRootBean.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\n\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\r\u0010\u000c\u001a\u0004\u0018\u00010\u0004\u00a2\u0006\u0002\u0010\rR\u0016\u0010\u0003\u001a\u0004\u0018\u00010\u00048\u0002@\u0002X\u0083\u000e\u00a2\u0006\u0004\n\u0002\u0010\u0005R$\u0010\u0007\u001a\u00020\u00042\u0006\u0010\u0006\u001a\u00020\u00048F@FX\u0086\u000e\u00a2\u0006\u000c\u001a\u0004\u0008\u0008\u0010\t\"\u0004\u0008\n\u0010\u000b\u00a8\u0006\u000e"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/ExtConfig;",
        "",
        "()V",
        "configuredReportEnabled",
        "",
        "Ljava/lang/Boolean;",
        "value",
        "reportEnabled",
        "getReportEnabled",
        "()Z",
        "setReportEnabled",
        "(Z)V",
        "configuredReportEnabledOrNull",
        "()Ljava/lang/Boolean;",
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
.field private configuredReportEnabled:Ljava/lang/Boolean;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "reportEnabled"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final configuredReportEnabledOrNull()Ljava/lang/Boolean;
    .locals 1

    .line 54
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/ExtConfig;->configuredReportEnabled:Ljava/lang/Boolean;

    return-object v0
.end method

.method public final getReportEnabled()Z
    .locals 2

    .line 49
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/ExtConfig;->configuredReportEnabled:Ljava/lang/Boolean;

    const/4 v1, 0x1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public final setReportEnabled(Z)V
    .locals 1
    .param p1, "value"    # Z

    .line 51
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/ExtConfig;->configuredReportEnabled:Ljava/lang/Boolean;

    .line 52
    return-void
.end method
