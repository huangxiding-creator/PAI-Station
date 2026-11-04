.class public final Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;
.super Ljava/lang/Object;
.source "AgentBean.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u001d\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001a\u0010\u000c\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u0006\"\u0004\u0008\u000e\u0010\u0008R\u001a\u0010\u000f\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u0006\"\u0004\u0008\u0011\u0010\u0008R\u001a\u0010\u0012\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u0006\"\u0004\u0008\u0014\u0010\u0008R\u001a\u0010\u0015\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0016\u0010\u0006\"\u0004\u0008\u0017\u0010\u0008R\u001a\u0010\u0018\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0019\u0010\u0006\"\u0004\u0008\u001a\u0010\u0008R\u001a\u0010\u001b\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001c\u0010\u0006\"\u0004\u0008\u001d\u0010\u0008R\u001a\u0010\u001e\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001f\u0010\u0006\"\u0004\u0008 \u0010\u0008\u00a8\u0006!"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;",
        "",
        "()V",
        "btMac",
        "",
        "getBtMac",
        "()Ljava/lang/String;",
        "setBtMac",
        "(Ljava/lang/String;)V",
        "deviceId",
        "getDeviceId",
        "setDeviceId",
        "deviceSubTypeId",
        "getDeviceSubTypeId",
        "setDeviceSubTypeId",
        "deviceTypeId",
        "getDeviceTypeId",
        "setDeviceTypeId",
        "osVersion",
        "getOsVersion",
        "setOsVersion",
        "p2pMac",
        "getP2pMac",
        "setP2pMac",
        "platform",
        "getPlatform",
        "setPlatform",
        "version",
        "getVersion",
        "setVersion",
        "wifiMac",
        "getWifiMac",
        "setWifiMac",
        "base-utils_release"
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
.field private btMac:Ljava/lang/String;

.field private deviceId:Ljava/lang/String;

.field private deviceSubTypeId:Ljava/lang/String;

.field private deviceTypeId:Ljava/lang/String;

.field private osVersion:Ljava/lang/String;

.field private p2pMac:Ljava/lang/String;

.field private platform:Ljava/lang/String;

.field private version:Ljava/lang/String;

.field private wifiMac:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 9
    const-string v0, "android"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->platform:Ljava/lang/String;

    .line 10
    const-string v0, "1.0.0"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->version:Ljava/lang/String;

    .line 11
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->deviceId:Ljava/lang/String;

    .line 12
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->btMac:Ljava/lang/String;

    .line 13
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->wifiMac:Ljava/lang/String;

    .line 14
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->p2pMac:Ljava/lang/String;

    .line 15
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->deviceTypeId:Ljava/lang/String;

    .line 16
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->deviceSubTypeId:Ljava/lang/String;

    .line 17
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->osVersion:Ljava/lang/String;

    .line 7
    return-void
.end method


# virtual methods
.method public final getBtMac()Ljava/lang/String;
    .locals 1

    .line 12
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->btMac:Ljava/lang/String;

    return-object v0
.end method

.method public final getDeviceId()Ljava/lang/String;
    .locals 1

    .line 11
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->deviceId:Ljava/lang/String;

    return-object v0
.end method

.method public final getDeviceSubTypeId()Ljava/lang/String;
    .locals 1

    .line 16
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->deviceSubTypeId:Ljava/lang/String;

    return-object v0
.end method

.method public final getDeviceTypeId()Ljava/lang/String;
    .locals 1

    .line 15
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->deviceTypeId:Ljava/lang/String;

    return-object v0
.end method

.method public final getOsVersion()Ljava/lang/String;
    .locals 1

    .line 17
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->osVersion:Ljava/lang/String;

    return-object v0
.end method

.method public final getP2pMac()Ljava/lang/String;
    .locals 1

    .line 14
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->p2pMac:Ljava/lang/String;

    return-object v0
.end method

.method public final getPlatform()Ljava/lang/String;
    .locals 1

    .line 9
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->platform:Ljava/lang/String;

    return-object v0
.end method

.method public final getVersion()Ljava/lang/String;
    .locals 1

    .line 10
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->version:Ljava/lang/String;

    return-object v0
.end method

.method public final getWifiMac()Ljava/lang/String;
    .locals 1

    .line 13
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->wifiMac:Ljava/lang/String;

    return-object v0
.end method

.method public final setBtMac(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->btMac:Ljava/lang/String;

    return-void
.end method

.method public final setDeviceId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 11
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->deviceId:Ljava/lang/String;

    return-void
.end method

.method public final setDeviceSubTypeId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 16
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->deviceSubTypeId:Ljava/lang/String;

    return-void
.end method

.method public final setDeviceTypeId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 15
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->deviceTypeId:Ljava/lang/String;

    return-void
.end method

.method public final setOsVersion(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 17
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->osVersion:Ljava/lang/String;

    return-void
.end method

.method public final setP2pMac(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 14
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->p2pMac:Ljava/lang/String;

    return-void
.end method

.method public final setPlatform(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 9
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->platform:Ljava/lang/String;

    return-void
.end method

.method public final setVersion(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 10
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->version:Ljava/lang/String;

    return-void
.end method

.method public final setWifiMac(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 13
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/AgentBean;->wifiMac:Ljava/lang/String;

    return-void
.end method
