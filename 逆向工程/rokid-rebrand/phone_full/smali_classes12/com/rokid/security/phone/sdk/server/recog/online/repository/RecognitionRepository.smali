.class public final Lcom/rokid/security/phone/sdk/server/recog/online/repository/RecognitionRepository;
.super Ljava/lang/Object;
.source "RecognitionRepository.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00004\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\u0008\u0000\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0008\u0010\u0003\u001a\u00020\u0004H\u0002J\u001a\u0010\u0005\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00080\u00070\u00062\u0006\u0010\t\u001a\u00020\u0004J \u0010\n\u001a\u0014\u0012\u0010\u0012\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u000c0\u000b0\u00070\u00062\u0006\u0010\r\u001a\u00020\u0004J\u001a\u0010\u000e\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u000f0\u00070\u00062\u0006\u0010\t\u001a\u00020\u0004\u00a8\u0006\u0010"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/recog/online/repository/RecognitionRepository;",
        "",
        "()V",
        "getTokenHeader",
        "",
        "personCheck",
        "Lkotlinx/coroutines/flow/Flow;",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;",
        "Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;",
        "cardno",
        "recognize",
        "",
        "Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;",
        "imageBase64",
        "vehicleCheck",
        "Lcom/rokid/security/sdk/base/common/out/VehicleCheckInfo;",
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


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final getTokenHeader()Ljava/lang/String;
    .locals 1

    .line 60
    const-string v0, "Bearer  "

    return-object v0
.end method


# virtual methods
.method public final personCheck(Ljava/lang/String;)Lkotlinx/coroutines/flow/Flow;
    .locals 4
    .param p1, "cardno"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;",
            ">;>;"
        }
    .end annotation

    const-string v0, "cardno"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    new-instance v0, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;-><init>()V

    move-object v1, v0

    .local v1, "$this$personCheck_u24lambda_u241":Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;
    const/4 v2, 0x0

    .line 43
    .local v2, "$i$a$-apply-RecognitionRepository$personCheck$deviceMeta$1":I
    const-string v3, ""

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;->setDeviceLong(Ljava/lang/String;)V

    .line 44
    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;->setDeviceLat(Ljava/lang/String;)V

    .line 45
    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;->setDeviceId(Ljava/lang/String;)V

    .line 46
    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;->setGlassId(Ljava/lang/String;)V

    .line 47
    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;->setDeviceIp(Ljava/lang/String;)V

    .line 48
    nop

    .line 42
    .end local v1    # "$this$personCheck_u24lambda_u241":Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;
    .end local v2    # "$i$a$-apply-RecognitionRepository$personCheck$deviceMeta$1":I
    nop

    .line 49
    .local v0, "deviceMeta":Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;
    new-instance v1, Lcom/rokid/security/phone/sdk/server/recog/online/param/PersonCheckParam;

    invoke-direct {v1, p1, v0}, Lcom/rokid/security/phone/sdk/server/recog/online/param/PersonCheckParam;-><init>(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;)V

    .line 50
    .local v1, "param":Lcom/rokid/security/phone/sdk/server/recog/online/param/PersonCheckParam;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->INSTANCE:Lcom/rokid/security/phone/sdk/server/net/ApiProvider;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->getApi()Lcom/rokid/security/phone/sdk/server/net/ApiService;

    move-result-object v2

    invoke-interface {v2, v1}, Lcom/rokid/security/phone/sdk/server/net/ApiService;->personCheck(Lcom/rokid/security/phone/sdk/server/recog/online/param/PersonCheckParam;)Lkotlinx/coroutines/flow/Flow;

    move-result-object v2

    return-object v2
.end method

.method public final recognize(Ljava/lang/String;)Lkotlinx/coroutines/flow/Flow;
    .locals 5
    .param p1, "imageBase64"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;",
            ">;>;>;"
        }
    .end annotation

    const-string v0, "imageBase64"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    new-instance v0, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;-><init>()V

    move-object v1, v0

    .local v1, "$this$recognize_u24lambda_u240":Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;
    const/4 v2, 0x0

    .line 26
    .local v2, "$i$a$-apply-RecognitionRepository$recognize$deviceMeta$1":I
    const-string v3, ""

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;->setDeviceLong(Ljava/lang/String;)V

    .line 27
    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;->setDeviceLat(Ljava/lang/String;)V

    .line 28
    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;->setDeviceId(Ljava/lang/String;)V

    .line 29
    sget-object v4, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->getGlassDeviceInfo()Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    move-result-object v4

    if-eqz v4, :cond_0

    invoke-virtual {v4}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getDeviceId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_1

    :cond_0
    move-object v4, v3

    :cond_1
    invoke-virtual {v1, v4}, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;->setGlassId(Ljava/lang/String;)V

    .line 30
    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;->setDeviceIp(Ljava/lang/String;)V

    .line 31
    nop

    .line 25
    .end local v1    # "$this$recognize_u24lambda_u240":Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;
    .end local v2    # "$i$a$-apply-RecognitionRepository$recognize$deviceMeta$1":I
    nop

    .line 32
    .local v0, "deviceMeta":Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/UserManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserManager;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/auth/UserManager;->getUserInfo()Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    move-result-object v1

    if-eqz v1, :cond_3

    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/outside/UserInfo;->getId()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_2

    goto :goto_0

    :cond_2
    move-object v3, v1

    :cond_3
    :goto_0
    move-object v1, v3

    .line 33
    .local v1, "userId":Ljava/lang/String;
    const-string v2, "80"

    .line 34
    .local v2, "similarity":Ljava/lang/String;
    new-instance v3, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;

    invoke-direct {v3, p1, v2, v1, v0}, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;)V

    .line 35
    .local v3, "param":Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->INSTANCE:Lcom/rokid/security/phone/sdk/server/net/ApiProvider;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->getApi()Lcom/rokid/security/phone/sdk/server/net/ApiService;

    move-result-object v4

    invoke-interface {v4, v3}, Lcom/rokid/security/phone/sdk/server/net/ApiService;->recognize(Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;)Lkotlinx/coroutines/flow/Flow;

    move-result-object v4

    return-object v4
.end method

.method public final vehicleCheck(Ljava/lang/String;)Lkotlinx/coroutines/flow/Flow;
    .locals 3
    .param p1, "cardno"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Lcom/rokid/security/sdk/base/common/out/VehicleCheckInfo;",
            ">;>;"
        }
    .end annotation

    const-string v0, "cardno"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 56
    new-instance v0, Lcom/rokid/security/phone/sdk/server/recog/online/param/VehicleCheckParam;

    const-string v1, "01"

    const-string v2, ""

    invoke-direct {v0, p1, v1, v2}, Lcom/rokid/security/phone/sdk/server/recog/online/param/VehicleCheckParam;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 57
    .local v0, "param":Lcom/rokid/security/phone/sdk/server/recog/online/param/VehicleCheckParam;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->INSTANCE:Lcom/rokid/security/phone/sdk/server/net/ApiProvider;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->getApi()Lcom/rokid/security/phone/sdk/server/net/ApiService;

    move-result-object v1

    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/recog/online/repository/RecognitionRepository;->getTokenHeader()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v0, v2}, Lcom/rokid/security/phone/sdk/server/net/ApiService;->vehicleCheck(Lcom/rokid/security/phone/sdk/server/recog/online/param/VehicleCheckParam;Ljava/lang/String;)Lkotlinx/coroutines/flow/Flow;

    move-result-object v1

    return-object v1
.end method
