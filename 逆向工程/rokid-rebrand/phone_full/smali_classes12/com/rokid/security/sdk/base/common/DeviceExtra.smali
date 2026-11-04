.class public final Lcom/rokid/security/sdk/base/common/DeviceExtra;
.super Ljava/lang/Object;
.source "DeviceExtra.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/base/common/DeviceExtra$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0010 \n\u0002\u0008\u001b\u0018\u0000 $2\u00020\u0001:\u0001$B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\"\u0010\t\u001a\n\u0012\u0004\u0012\u00020\u0004\u0018\u00010\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000eR\u001a\u0010\u000f\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u0006\"\u0004\u0008\u0011\u0010\u0008R\u001a\u0010\u0012\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u0006\"\u0004\u0008\u0014\u0010\u0008R\u001a\u0010\u0015\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0016\u0010\u0006\"\u0004\u0008\u0017\u0010\u0008R\u001a\u0010\u0018\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0019\u0010\u0006\"\u0004\u0008\u001a\u0010\u0008R\u001a\u0010\u001b\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001c\u0010\u0006\"\u0004\u0008\u001d\u0010\u0008R\u001a\u0010\u001e\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001f\u0010\u0006\"\u0004\u0008 \u0010\u0008R\u001a\u0010!\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\"\u0010\u0006\"\u0004\u0008#\u0010\u0008\u00a8\u0006%"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/DeviceExtra;",
        "",
        "()V",
        "btMac",
        "",
        "getBtMac",
        "()Ljava/lang/String;",
        "setBtMac",
        "(Ljava/lang/String;)V",
        "capabilities",
        "",
        "getCapabilities",
        "()Ljava/util/List;",
        "setCapabilities",
        "(Ljava/util/List;)V",
        "deviceId",
        "getDeviceId",
        "setDeviceId",
        "deviceSubType",
        "getDeviceSubType",
        "setDeviceSubType",
        "deviceType",
        "getDeviceType",
        "setDeviceType",
        "methodName",
        "getMethodName",
        "setMethodName",
        "osVersion",
        "getOsVersion",
        "setOsVersion",
        "p2pMac",
        "getP2pMac",
        "setP2pMac",
        "wifiMac",
        "getWifiMac",
        "setWifiMac",
        "Companion",
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


# static fields
.field public static final CAPABILITY_COMPANION_SESSION_CONTROL_V1:Ljava/lang/String; = "companion_session_control_v1"

.field public static final Companion:Lcom/rokid/security/sdk/base/common/DeviceExtra$Companion;


# instance fields
.field private btMac:Ljava/lang/String;

.field private capabilities:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private deviceId:Ljava/lang/String;

.field private deviceSubType:Ljava/lang/String;

.field private deviceType:Ljava/lang/String;

.field private methodName:Ljava/lang/String;

.field private osVersion:Ljava/lang/String;

.field private p2pMac:Ljava/lang/String;

.field private wifiMac:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/sdk/base/common/DeviceExtra$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/sdk/base/common/DeviceExtra$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->Companion:Lcom/rokid/security/sdk/base/common/DeviceExtra$Companion;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->methodName:Ljava/lang/String;

    .line 22
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->deviceId:Ljava/lang/String;

    .line 24
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->deviceType:Ljava/lang/String;

    .line 25
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->deviceSubType:Ljava/lang/String;

    .line 27
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->btMac:Ljava/lang/String;

    .line 28
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->wifiMac:Ljava/lang/String;

    .line 29
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->p2pMac:Ljava/lang/String;

    .line 30
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->osVersion:Ljava/lang/String;

    .line 13
    return-void
.end method


# virtual methods
.method public final getBtMac()Ljava/lang/String;
    .locals 1

    .line 27
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->btMac:Ljava/lang/String;

    return-object v0
.end method

.method public final getCapabilities()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 34
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->capabilities:Ljava/util/List;

    return-object v0
.end method

.method public final getDeviceId()Ljava/lang/String;
    .locals 1

    .line 22
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->deviceId:Ljava/lang/String;

    return-object v0
.end method

.method public final getDeviceSubType()Ljava/lang/String;
    .locals 1

    .line 25
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->deviceSubType:Ljava/lang/String;

    return-object v0
.end method

.method public final getDeviceType()Ljava/lang/String;
    .locals 1

    .line 24
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->deviceType:Ljava/lang/String;

    return-object v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 20
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getOsVersion()Ljava/lang/String;
    .locals 1

    .line 30
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->osVersion:Ljava/lang/String;

    return-object v0
.end method

.method public final getP2pMac()Ljava/lang/String;
    .locals 1

    .line 29
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->p2pMac:Ljava/lang/String;

    return-object v0
.end method

.method public final getWifiMac()Ljava/lang/String;
    .locals 1

    .line 28
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->wifiMac:Ljava/lang/String;

    return-object v0
.end method

.method public final setBtMac(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 27
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->btMac:Ljava/lang/String;

    return-void
.end method

.method public final setCapabilities(Ljava/util/List;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 34
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->capabilities:Ljava/util/List;

    return-void
.end method

.method public final setDeviceId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 22
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->deviceId:Ljava/lang/String;

    return-void
.end method

.method public final setDeviceSubType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->deviceSubType:Ljava/lang/String;

    return-void
.end method

.method public final setDeviceType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->deviceType:Ljava/lang/String;

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 20
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setOsVersion(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 30
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->osVersion:Ljava/lang/String;

    return-void
.end method

.method public final setP2pMac(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 29
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->p2pMac:Ljava/lang/String;

    return-void
.end method

.method public final setWifiMac(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 28
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/DeviceExtra;->wifiMac:Ljava/lang/String;

    return-void
.end method
