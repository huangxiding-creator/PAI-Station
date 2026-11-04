.class public final Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultImpls;
.super Ljava/lang/Object;
.source "IDevice.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/api/device/IDevice;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "DefaultImpls"
.end annotation

.annotation runtime Lkotlin/Metadata;
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public static synthetic requestVideoStream$default(Lcom/rokid/security/phone/sdk/api/device/IDevice;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 14
    if-nez p5, :cond_1

    and-int/lit8 p4, p4, 0x2

    if-eqz p4, :cond_0

    new-instance p2, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;

    invoke-direct {p2}, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;-><init>()V

    :cond_0
    invoke-interface {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/api/device/IDevice;->requestVideoStream(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;Lkotlin/jvm/functions/Function1;)V

    return-void

    :cond_1
    new-instance p0, Ljava/lang/UnsupportedOperationException;

    const-string p1, "Super calls with default arguments not supported in this target, function: requestVideoStream"

    invoke-direct {p0, p1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static synthetic setDeviceApp$default(Lcom/rokid/security/phone/sdk/api/device/IDevice;Ljava/util/List;Ljava/util/List;Ljava/lang/String;ILjava/lang/Object;)V
    .locals 1

    .line 23
    if-nez p5, :cond_3

    and-int/lit8 p5, p4, 0x1

    const/4 v0, 0x0

    if-eqz p5, :cond_0

    .line 24
    move-object p1, v0

    .line 23
    :cond_0
    and-int/lit8 p5, p4, 0x2

    if-eqz p5, :cond_1

    .line 25
    move-object p2, v0

    .line 23
    :cond_1
    and-int/lit8 p4, p4, 0x4

    if-eqz p4, :cond_2

    .line 26
    move-object p3, v0

    .line 23
    :cond_2
    invoke-interface {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/api/device/IDevice;->setDeviceApp(Ljava/util/List;Ljava/util/List;Ljava/lang/String;)V

    return-void

    :cond_3
    new-instance p0, Ljava/lang/UnsupportedOperationException;

    const-string p1, "Super calls with default arguments not supported in this target, function: setDeviceApp"

    invoke-direct {p0, p1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p0
.end method
