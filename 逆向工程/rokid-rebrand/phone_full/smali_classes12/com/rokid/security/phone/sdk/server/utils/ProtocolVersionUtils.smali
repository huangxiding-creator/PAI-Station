.class public final Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;
.super Ljava/lang/Object;
.source "ProtocolVersionUtils.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000 \n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0007\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0005\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0005\u001a\u00020\u0006J\u0006\u0010\u0007\u001a\u00020\u0008J\u0006\u0010\t\u001a\u00020\u0008J\u000e\u0010\n\u001a\u00020\u00082\u0006\u0010\u000b\u001a\u00020\u0004J\u0006\u0010\u000c\u001a\u00020\u0008R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\r"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;",
        "",
        "()V",
        "TAG",
        "",
        "getPhoneProtocolVersion",
        "",
        "is1080PLandDefault",
        "",
        "isGlassLowVersion3",
        "isGlassVersionLowerTarget",
        "targetVersion",
        "isNeedUseSendMessageV2",
        "sdk-server_release"
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;

.field private static final TAG:Ljava/lang/String; = "ProtocolVersionUtils"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getPhoneProtocolVersion()F
    .locals 1

    .line 20
    const-string v0, "5.0"

    invoke-static {v0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v0

    return v0
.end method

.method public final is1080PLandDefault()Z
    .locals 5

    .line 78
    sget-object v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->getGlassDeviceInfo()Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    move-result-object v0

    .line 79
    .local v0, "mDevicesInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 80
    return v1

    .line 82
    :cond_0
    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getVersion()Ljava/lang/String;

    move-result-object v2

    .line 83
    .local v2, "glassProtocolVersion":Ljava/lang/String;
    invoke-static {v2}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v3

    const-string v4, "5.0"

    invoke-static {v4}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v4

    cmpl-float v3, v3, v4

    if-ltz v3, :cond_1

    const/4 v1, 0x1

    :cond_1
    return v1
.end method

.method public final isGlassLowVersion3()Z
    .locals 5

    .line 27
    sget-object v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->getGlassDeviceInfo()Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    move-result-object v0

    .line 28
    .local v0, "mDevicesInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 29
    return v1

    .line 31
    :cond_0
    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getVersion()Ljava/lang/String;

    move-result-object v2

    .line 33
    .local v2, "glassProtocolVersion":Ljava/lang/String;
    invoke-static {v2}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v3

    const-string v4, "3.0"

    invoke-static {v4}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v4

    cmpg-float v3, v3, v4

    if-gez v3, :cond_1

    const/4 v1, 0x1

    :cond_1
    return v1
.end method

.method public final isGlassVersionLowerTarget(Ljava/lang/String;)Z
    .locals 5
    .param p1, "targetVersion"    # Ljava/lang/String;

    const-string/jumbo v0, "targetVersion"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 38
    sget-object v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->getGlassDeviceInfo()Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    move-result-object v0

    .line 39
    .local v0, "mDevicesInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 40
    return v1

    .line 42
    :cond_0
    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getVersion()Ljava/lang/String;

    move-result-object v2

    .line 44
    .local v2, "glassProtocolVersion":Ljava/lang/String;
    invoke-static {v2}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v3

    invoke-static {p1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v4

    cmpg-float v3, v3, v4

    if-gez v3, :cond_1

    const/4 v1, 0x1

    :cond_1
    return v1
.end method

.method public final isNeedUseSendMessageV2()Z
    .locals 6

    .line 53
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;->getPhoneProtocolVersion()F

    move-result v0

    .line 55
    .local v0, "phoneProtocolVersion":F
    const-string v1, "4.0"

    invoke-static {v1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v2

    cmpg-float v2, v0, v2

    const/4 v3, 0x0

    if-gez v2, :cond_0

    .line 56
    return v3

    .line 59
    :cond_0
    sget-object v2, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->getGlassDeviceInfo()Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    move-result-object v2

    .line 60
    .local v2, "mDevicesInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    if-nez v2, :cond_1

    .line 61
    const-string v1, "isNeedUseSendMessageV2: mDevicesInfo == null"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v4, "ProtocolVersionUtils"

    invoke-static {v4, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 62
    return v3

    .line 64
    :cond_1
    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getVersion()Ljava/lang/String;

    move-result-object v4

    .line 66
    .local v4, "glassProtocolVersion":Ljava/lang/String;
    invoke-static {v4}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v5

    invoke-static {v1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v1

    cmpg-float v1, v5, v1

    if-gez v1, :cond_2

    .line 67
    return v3

    .line 69
    :cond_2
    const/4 v1, 0x1

    return v1
.end method
