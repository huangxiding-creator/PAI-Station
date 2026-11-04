.class public final Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;
.super Ljava/lang/Object;
.source "GlassDeviceInfo.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000$\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0008\n\u0002\u0010\u000e\n\u0002\u0008\u0008\n\u0002\u0010\u000b\n\u0002\u0008\u0012\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001a\u0010\u000c\u001a\u00020\rX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000e\u0010\u000f\"\u0004\u0008\u0010\u0010\u0011R\u001a\u0010\u0012\u001a\u00020\rX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u000f\"\u0004\u0008\u0014\u0010\u0011R\u001a\u0010\u0015\u001a\u00020\u0016X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0015\u0010\u0017\"\u0004\u0008\u0018\u0010\u0019R\u001a\u0010\u001a\u001a\u00020\u0016X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001a\u0010\u0017\"\u0004\u0008\u001b\u0010\u0019R\u001a\u0010\u001c\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001d\u0010\u0006\"\u0004\u0008\u001e\u0010\u0008R\u001a\u0010\u001f\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008 \u0010\u0006\"\u0004\u0008!\u0010\u0008R\u001a\u0010\"\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008#\u0010\u0006\"\u0004\u0008$\u0010\u0008R\u001a\u0010%\u001a\u00020\rX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008&\u0010\u000f\"\u0004\u0008\'\u0010\u0011\u00a8\u0006("
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;",
        "",
        "()V",
        "brightness",
        "",
        "getBrightness",
        "()I",
        "setBrightness",
        "(I)V",
        "curVolume",
        "getCurVolume",
        "setCurVolume",
        "deviceId",
        "",
        "getDeviceId",
        "()Ljava/lang/String;",
        "setDeviceId",
        "(Ljava/lang/String;)V",
        "deviceTypeId",
        "getDeviceTypeId",
        "setDeviceTypeId",
        "isAutoBrightness",
        "",
        "()Z",
        "setAutoBrightness",
        "(Z)V",
        "isCharge",
        "setCharge",
        "maxBrightness",
        "getMaxBrightness",
        "setMaxBrightness",
        "maxVolume",
        "getMaxVolume",
        "setMaxVolume",
        "powerValue",
        "getPowerValue",
        "setPowerValue",
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
.field private brightness:I

.field private curVolume:I

.field private deviceId:Ljava/lang/String;

.field private deviceTypeId:Ljava/lang/String;

.field private isAutoBrightness:Z

.field private isCharge:Z

.field private maxBrightness:I

.field private maxVolume:I

.field private powerValue:I

.field private version:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->version:Ljava/lang/String;

    .line 19
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->deviceId:Ljava/lang/String;

    .line 20
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->deviceTypeId:Ljava/lang/String;

    .line 24
    const/16 v0, 0xff

    iput v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->maxBrightness:I

    .line 26
    const/16 v0, 0x8

    iput v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->curVolume:I

    .line 27
    const/16 v0, 0xf

    iput v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->maxVolume:I

    .line 17
    return-void
.end method


# virtual methods
.method public final getBrightness()I
    .locals 1

    .line 23
    iget v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->brightness:I

    return v0
.end method

.method public final getCurVolume()I
    .locals 1

    .line 26
    iget v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->curVolume:I

    return v0
.end method

.method public final getDeviceId()Ljava/lang/String;
    .locals 1

    .line 19
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->deviceId:Ljava/lang/String;

    return-object v0
.end method

.method public final getDeviceTypeId()Ljava/lang/String;
    .locals 1

    .line 20
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->deviceTypeId:Ljava/lang/String;

    return-object v0
.end method

.method public final getMaxBrightness()I
    .locals 1

    .line 24
    iget v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->maxBrightness:I

    return v0
.end method

.method public final getMaxVolume()I
    .locals 1

    .line 27
    iget v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->maxVolume:I

    return v0
.end method

.method public final getPowerValue()I
    .locals 1

    .line 22
    iget v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->powerValue:I

    return v0
.end method

.method public final getVersion()Ljava/lang/String;
    .locals 1

    .line 18
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->version:Ljava/lang/String;

    return-object v0
.end method

.method public final isAutoBrightness()Z
    .locals 1

    .line 25
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->isAutoBrightness:Z

    return v0
.end method

.method public final isCharge()Z
    .locals 1

    .line 21
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->isCharge:Z

    return v0
.end method

.method public final setAutoBrightness(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 25
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->isAutoBrightness:Z

    return-void
.end method

.method public final setBrightness(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 23
    iput p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->brightness:I

    return-void
.end method

.method public final setCharge(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 21
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->isCharge:Z

    return-void
.end method

.method public final setCurVolume(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 26
    iput p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->curVolume:I

    return-void
.end method

.method public final setDeviceId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->deviceId:Ljava/lang/String;

    return-void
.end method

.method public final setDeviceTypeId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 20
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->deviceTypeId:Ljava/lang/String;

    return-void
.end method

.method public final setMaxBrightness(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 24
    iput p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->maxBrightness:I

    return-void
.end method

.method public final setMaxVolume(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 27
    iput p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->maxVolume:I

    return-void
.end method

.method public final setPowerValue(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 22
    iput p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->powerValue:I

    return-void
.end method

.method public final setVersion(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 18
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/out/GlassSystemInfo;->version:Ljava/lang/String;

    return-void
.end method
