.class public final Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
.super Ljava/lang/Object;
.source "GlassDeviceInfo.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u001a\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001a\u0010\u000c\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u0006\"\u0004\u0008\u000e\u0010\u0008R\u001a\u0010\u000f\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u0006\"\u0004\u0008\u0011\u0010\u0008R\u001a\u0010\u0012\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u0006\"\u0004\u0008\u0014\u0010\u0008R\u001a\u0010\u0015\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0016\u0010\u0006\"\u0004\u0008\u0017\u0010\u0008R\u001a\u0010\u0018\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0019\u0010\u0006\"\u0004\u0008\u001a\u0010\u0008R\u001a\u0010\u001b\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001c\u0010\u0006\"\u0004\u0008\u001d\u0010\u0008\u00a8\u0006\u001e"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;",
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
        "deviceSubType",
        "getDeviceSubType",
        "setDeviceSubType",
        "deviceType",
        "getDeviceType",
        "setDeviceType",
        "osVersion",
        "getOsVersion",
        "setOsVersion",
        "p2pMac",
        "getP2pMac",
        "setP2pMac",
        "version",
        "getVersion",
        "setVersion",
        "wifiMac",
        "getWifiMac",
        "setWifiMac",
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
.field private btMac:Ljava/lang/String;

.field private deviceId:Ljava/lang/String;

.field private deviceSubType:Ljava/lang/String;

.field private deviceType:Ljava/lang/String;

.field private osVersion:Ljava/lang/String;

.field private p2pMac:Ljava/lang/String;

.field private version:Ljava/lang/String;

.field private wifiMac:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 7
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->deviceId:Ljava/lang/String;

    .line 8
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->deviceType:Ljava/lang/String;

    .line 9
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->deviceSubType:Ljava/lang/String;

    .line 10
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->btMac:Ljava/lang/String;

    .line 11
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->wifiMac:Ljava/lang/String;

    .line 12
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->p2pMac:Ljava/lang/String;

    .line 13
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->version:Ljava/lang/String;

    .line 14
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->osVersion:Ljava/lang/String;

    .line 6
    return-void
.end method


# virtual methods
.method public final getBtMac()Ljava/lang/String;
    .locals 1

    .line 10
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->btMac:Ljava/lang/String;

    return-object v0
.end method

.method public final getDeviceId()Ljava/lang/String;
    .locals 1

    .line 7
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->deviceId:Ljava/lang/String;

    return-object v0
.end method

.method public final getDeviceSubType()Ljava/lang/String;
    .locals 1

    .line 9
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->deviceSubType:Ljava/lang/String;

    return-object v0
.end method

.method public final getDeviceType()Ljava/lang/String;
    .locals 1

    .line 8
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->deviceType:Ljava/lang/String;

    return-object v0
.end method

.method public final getOsVersion()Ljava/lang/String;
    .locals 1

    .line 14
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->osVersion:Ljava/lang/String;

    return-object v0
.end method

.method public final getP2pMac()Ljava/lang/String;
    .locals 1

    .line 12
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->p2pMac:Ljava/lang/String;

    return-object v0
.end method

.method public final getVersion()Ljava/lang/String;
    .locals 1

    .line 13
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->version:Ljava/lang/String;

    return-object v0
.end method

.method public final getWifiMac()Ljava/lang/String;
    .locals 1

    .line 11
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->wifiMac:Ljava/lang/String;

    return-object v0
.end method

.method public final setBtMac(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 10
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->btMac:Ljava/lang/String;

    return-void
.end method

.method public final setDeviceId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 7
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->deviceId:Ljava/lang/String;

    return-void
.end method

.method public final setDeviceSubType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 9
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->deviceSubType:Ljava/lang/String;

    return-void
.end method

.method public final setDeviceType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 8
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->deviceType:Ljava/lang/String;

    return-void
.end method

.method public final setOsVersion(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 14
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->osVersion:Ljava/lang/String;

    return-void
.end method

.method public final setP2pMac(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->p2pMac:Ljava/lang/String;

    return-void
.end method

.method public final setVersion(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 13
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->version:Ljava/lang/String;

    return-void
.end method

.method public final setWifiMac(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 11
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->wifiMac:Ljava/lang/String;

    return-void
.end method
