.class public final Lcom/rokid/security/sdk/base/common/ota/SystemInfo;
.super Ljava/lang/Object;
.source "SystemInfo.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0011\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001e\u0010\u0003\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001e\u0010\t\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001e\u0010\u000c\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u0006\"\u0004\u0008\u000e\u0010\u0008R\u001e\u0010\u000f\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u0006\"\u0004\u0008\u0011\u0010\u0008R\u001e\u0010\u0012\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u0006\"\u0004\u0008\u0014\u0010\u0008\u00a8\u0006\u0015"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/ota/SystemInfo;",
        "",
        "()V",
        "cpuType",
        "",
        "getCpuType",
        "()Ljava/lang/String;",
        "setCpuType",
        "(Ljava/lang/String;)V",
        "deviceTypeId",
        "getDeviceTypeId",
        "setDeviceTypeId",
        "device_id",
        "getDevice_id",
        "setDevice_id",
        "osType",
        "getOsType",
        "setOsType",
        "version",
        "getVersion",
        "setVersion",
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
.field private cpuType:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "cpuType"
    .end annotation
.end field

.field private deviceTypeId:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "deviceTypeId"
    .end annotation
.end field

.field private device_id:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "device_id"
    .end annotation
.end field

.field private osType:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "osType"
    .end annotation
.end field

.field private version:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "version"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->device_id:Ljava/lang/String;

    .line 15
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->deviceTypeId:Ljava/lang/String;

    .line 18
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->version:Ljava/lang/String;

    .line 21
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->osType:Ljava/lang/String;

    .line 24
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->cpuType:Ljava/lang/String;

    .line 9
    return-void
.end method


# virtual methods
.method public final getCpuType()Ljava/lang/String;
    .locals 1

    .line 24
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->cpuType:Ljava/lang/String;

    return-object v0
.end method

.method public final getDeviceTypeId()Ljava/lang/String;
    .locals 1

    .line 15
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->deviceTypeId:Ljava/lang/String;

    return-object v0
.end method

.method public final getDevice_id()Ljava/lang/String;
    .locals 1

    .line 12
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->device_id:Ljava/lang/String;

    return-object v0
.end method

.method public final getOsType()Ljava/lang/String;
    .locals 1

    .line 21
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->osType:Ljava/lang/String;

    return-object v0
.end method

.method public final getVersion()Ljava/lang/String;
    .locals 1

    .line 18
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->version:Ljava/lang/String;

    return-object v0
.end method

.method public final setCpuType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->cpuType:Ljava/lang/String;

    return-void
.end method

.method public final setDeviceTypeId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 15
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->deviceTypeId:Ljava/lang/String;

    return-void
.end method

.method public final setDevice_id(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->device_id:Ljava/lang/String;

    return-void
.end method

.method public final setOsType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 21
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->osType:Ljava/lang/String;

    return-void
.end method

.method public final setVersion(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 18
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->version:Ljava/lang/String;

    return-void
.end method
