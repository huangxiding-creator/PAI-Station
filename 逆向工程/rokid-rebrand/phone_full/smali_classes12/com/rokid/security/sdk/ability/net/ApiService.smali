.class public interface abstract Lcom/rokid/security/sdk/ability/net/ApiService;
.super Ljava/lang/Object;
.source "ApiService.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/net/ApiService$Companion;,
        Lcom/rokid/security/sdk/ability/net/ApiService$DefaultImpls;,
        Lcom/rokid/security/sdk/ability/net/ApiService$Headers;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u00d2\u0001\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010$\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008f\u0018\u0000 C2\u00020\u0001:\u0002CDJ\u001e\u0010\u0002\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00050\u00040\u00032\u0008\u0008\u0001\u0010\u0006\u001a\u00020\u0007H\'J\u0014\u0010\u0008\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\n0\t0\u0003H\'J\u001e\u0010\u000b\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u000e0\r0\u000c2\u0008\u0008\u0001\u0010\u000f\u001a\u00020\u0010H\'J\u0014\u0010\u0011\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00120\t0\u0003H\'J:\u0010\u0013\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00140\t0\u00032$\u0008\u0001\u0010\u0015\u001a\u001e\u0012\u0004\u0012\u00020\u0010\u0012\u0004\u0012\u00020\u00100\u0016j\u000e\u0012\u0004\u0012\u00020\u0010\u0012\u0004\u0012\u00020\u0010`\u0017H\'J$\u0010\u0018\u001a\u0014\u0012\u0010\u0012\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u001a0\u00190\t0\u00032\u0008\u0008\u0001\u0010\u0006\u001a\u00020\u001bH\'J*\u0010\u001c\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u001d0\t0\u00032\u0014\u0008\u0001\u0010\u0015\u001a\u000e\u0012\u0004\u0012\u00020\u0010\u0012\u0004\u0012\u00020\u00100\u001eH\'J\u001a\u0010\u001f\u001a\u0014\u0012\u0010\u0012\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020 0\u00190\t0\u0003H\'J0\u0010!\u001a\u0014\u0012\u0010\u0012\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\"0\u00190\t0\u00032\u0014\u0008\u0001\u0010\u0015\u001a\u000e\u0012\u0004\u0012\u00020\u0010\u0012\u0004\u0012\u00020\u00100\u001eH\'J\u0014\u0010#\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020$0\u00040\u0003H\'J,\u0010%\u001a\u0008\u0012\u0004\u0012\u00020&0\u00032\u0008\u0008\u0001\u0010\'\u001a\u00020\u00102\u0008\u0008\u0001\u0010(\u001a\u00020\u00102\u0008\u0008\u0001\u0010\u0006\u001a\u00020)H\'J\u001e\u0010*\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020+0\r0\u00032\u0008\u0008\u0001\u0010\u0006\u001a\u00020,H\'J\u001e\u0010-\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020+0\u00040\u00032\u0008\u0008\u0001\u0010\u0006\u001a\u00020,H\'J\u001e\u0010.\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00010\r0\u000c2\u0008\u0008\u0001\u0010/\u001a\u000200H\'J\u001e\u00101\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00100\t0\u00032\u0008\u0008\u0001\u0010\u0006\u001a\u000202H\'JH\u00103\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002040\u00040\u000c2\u0008\u0008\u0001\u00105\u001a\u0002062\n\u0008\u0003\u00107\u001a\u0004\u0018\u0001082\u0008\u0008\u0001\u00109\u001a\u0002082\u0008\u0008\u0001\u0010:\u001a\u00020;2\u0008\u0008\u0001\u0010(\u001a\u00020\u0010H\'J\u001e\u0010<\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00010\u00040\u00032\u0008\u0008\u0001\u0010/\u001a\u00020=H\'J\u001e\u0010>\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00100\t0\u00032\u0008\u0008\u0001\u0010?\u001a\u00020@H\'J\u001e\u0010A\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00010\u00040\u00032\u0008\u0008\u0001\u0010/\u001a\u00020BH\'\u00a8\u0006E"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/net/ApiService;",
        "",
        "asrIntent",
        "Lkotlinx/coroutines/flow/Flow;",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;",
        "Lcom/rokid/security/sdk/ability/param/AsrIntent;",
        "param",
        "Lcom/rokid/security/sdk/ability/param/AsrRequestParam;",
        "getAppListConfig",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;",
        "Lcom/rokid/security/sdk/base/common/market/AppData;",
        "getGb28181Config",
        "Lretrofit2/Call;",
        "Lcom/rokid/security/sdk/base/common/outside/CommonApiResponse;",
        "Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;",
        "sn",
        "",
        "getLauncherConfig",
        "Lcom/rokid/security/sdk/ability/param/LauncherRootBean;",
        "getPersonnelInfo",
        "Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;",
        "map",
        "Ljava/util/HashMap;",
        "Lkotlin/collections/HashMap;",
        "getPersonnelLib",
        "",
        "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
        "Lcom/rokid/security/sdk/ability/param/LibraryParam;",
        "getPlateNum",
        "Lcom/rokid/security/sdk/base/common/outside/VehiclePlateInfo;",
        "",
        "getSwitchConfig",
        "Lcom/rokid/security/sdk/ability/param/SwitchHot;",
        "getVehicleLibrary",
        "Lcom/rokid/security/sdk/base/common/outside/VehicleLibraryInfo;",
        "identificationEnd",
        "",
        "otaCheck",
        "Lcom/rokid/security/sdk/base/common/ota/OTAResponse;",
        "url",
        "token",
        "Lcom/rokid/security/sdk/base/common/ota/SystemInfo;",
        "refreshGb28181DeviceToken",
        "Lcom/rokid/security/sdk/base/common/auth/SdkToken;",
        "Lcom/rokid/security/sdk/base/common/auth/SdkTokenRequest;",
        "refreshToken",
        "reportGb28181Status",
        "request",
        "Lcom/rokid/security/sdk/base/common/outside/DeviceRegisterStatusDTO;",
        "submitRecognizedFaceInfo",
        "Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;",
        "uploadFile",
        "Lcom/rokid/security/sdk/base/common/filesystem/FileUpdateBean;",
        "file",
        "Lokhttp3/MultipartBody$Part;",
        "tag",
        "Lokhttp3/RequestBody;",
        "personId",
        "deviceMeta",
        "Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;",
        "uploadPhoto",
        "Lcom/rokid/security/sdk/ability/param/PhotoUploadRequest;",
        "uploadPlateResult",
        "result",
        "Lcom/rokid/security/sdk/base/common/outside/SendResult;",
        "uploadVideo",
        "Lcom/rokid/security/sdk/ability/param/VideoUploadRequest;",
        "Companion",
        "Headers",
        "sdk-common-ability_release"
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
.field public static final Companion:Lcom/rokid/security/sdk/ability/net/ApiService$Companion;

.field public static final TOKEN:Ljava/lang/String; = "Authorization"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Lcom/rokid/security/sdk/ability/net/ApiService$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/ability/net/ApiService$Companion;

    sput-object v0, Lcom/rokid/security/sdk/ability/net/ApiService;->Companion:Lcom/rokid/security/sdk/ability/net/ApiService$Companion;

    return-void
.end method


# virtual methods
.method public abstract asrIntent(Lcom/rokid/security/sdk/ability/param/AsrRequestParam;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/sdk/ability/param/AsrRequestParam;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/ability/param/AsrRequestParam;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3<",
            "Lcom/rokid/security/sdk/ability/param/AsrIntent;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/assistant/api/v2/intent"
    .end annotation
.end method

.method public abstract getAppListConfig()Lkotlinx/coroutines/flow/Flow;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Lcom/rokid/security/sdk/base/common/market/AppData;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/GET;
        value = "/ar/flow/web/app/list"
    .end annotation
.end method

.method public abstract getGb28181Config(Ljava/lang/String;)Lretrofit2/Call;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit2/http/Query;
            value = "deviceSn"
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lretrofit2/Call<",
            "Lcom/rokid/security/sdk/base/common/outside/CommonApiResponse<",
            "Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/GET;
        value = "/ar/core/api/device/gbPlatformConfig"
    .end annotation
.end method

.method public abstract getLauncherConfig()Lkotlinx/coroutines/flow/Flow;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Lcom/rokid/security/sdk/ability/param/LauncherRootBean;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/GET;
        value = "/ar/flow/api/v1/glassConfig/launcher"
    .end annotation
.end method

.method public abstract getPersonnelInfo(Ljava/util/HashMap;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Ljava/util/HashMap;
        .annotation runtime Lretrofit2/http/QueryMap;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/GET;
        value = "/ar/algorithm/api/manage/personnelSync/detail"
    .end annotation
.end method

.method public abstract getPersonnelLib(Lcom/rokid/security/sdk/ability/param/LibraryParam;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/sdk/ability/param/LibraryParam;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/ability/param/LibraryParam;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
            ">;>;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/algorithm/api/manage/personnelLibrary/sync"
    .end annotation
.end method

.method public abstract getPlateNum(Ljava/util/Map;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Ljava/util/Map;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Lcom/rokid/security/sdk/base/common/outside/VehiclePlateInfo;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/algorithm/api/vehicle/plateNum/get"
    .end annotation
.end method

.method public abstract getSwitchConfig()Lkotlinx/coroutines/flow/Flow;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/ability/param/SwitchHot;",
            ">;>;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/GET;
        value = "/ar/flow/api/v1/glassConfig/switch"
    .end annotation
.end method

.method public abstract getVehicleLibrary(Ljava/util/Map;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Ljava/util/Map;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/VehicleLibraryInfo;",
            ">;>;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/algorithm/api/vehicle/database/get"
    .end annotation
.end method

.method public abstract identificationEnd()Lkotlinx/coroutines/flow/Flow;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3<",
            "Ljava/lang/Boolean;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/flow/api/v1/identification/end"
    .end annotation
.end method

.method public abstract otaCheck(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/ota/SystemInfo;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit2/http/Url;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit2/http/Header;
            value = "Authorization"
        .end annotation
    .end param
    .param p3    # Lcom/rokid/security/sdk/base/common/ota/SystemInfo;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/rokid/security/sdk/base/common/ota/SystemInfo;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/sdk/base/common/ota/OTAResponse;",
            ">;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
    .end annotation
.end method

.method public abstract refreshGb28181DeviceToken(Lcom/rokid/security/sdk/base/common/auth/SdkTokenRequest;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/sdk/base/common/auth/SdkTokenRequest;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/base/common/auth/SdkTokenRequest;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/sdk/base/common/outside/CommonApiResponse<",
            "Lcom/rokid/security/sdk/base/common/auth/SdkToken;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/iam/auth/app/refresh"
    .end annotation
.end method

.method public abstract refreshToken(Lcom/rokid/security/sdk/base/common/auth/SdkTokenRequest;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/sdk/base/common/auth/SdkTokenRequest;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/base/common/auth/SdkTokenRequest;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3<",
            "Lcom/rokid/security/sdk/base/common/auth/SdkToken;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/iam/auth/app/refresh"
    .end annotation
.end method

.method public abstract reportGb28181Status(Lcom/rokid/security/sdk/base/common/outside/DeviceRegisterStatusDTO;)Lretrofit2/Call;
    .param p1    # Lcom/rokid/security/sdk/base/common/outside/DeviceRegisterStatusDTO;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/base/common/outside/DeviceRegisterStatusDTO;",
            ")",
            "Lretrofit2/Call<",
            "Lcom/rokid/security/sdk/base/common/outside/CommonApiResponse<",
            "Ljava/lang/Object;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/core/api/device/registerStatus"
    .end annotation
.end method

.method public abstract submitRecognizedFaceInfo(Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/algorithm/api/person/face/record/report"
    .end annotation
.end method

.method public abstract uploadFile(Lokhttp3/MultipartBody$Part;Lokhttp3/RequestBody;Lokhttp3/RequestBody;Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;Ljava/lang/String;)Lretrofit2/Call;
    .param p1    # Lokhttp3/MultipartBody$Part;
        .annotation runtime Lretrofit2/http/Part;
        .end annotation
    .end param
    .param p2    # Lokhttp3/RequestBody;
        .annotation runtime Lretrofit2/http/Part;
            value = "tag"
        .end annotation
    .end param
    .param p3    # Lokhttp3/RequestBody;
        .annotation runtime Lretrofit2/http/Part;
            value = "personId"
        .end annotation
    .end param
    .param p4    # Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;
        .annotation runtime Lretrofit2/http/Part;
            value = "device_meta"
        .end annotation
    .end param
    .param p5    # Ljava/lang/String;
        .annotation runtime Lretrofit2/http/Header;
            value = "Authorization"
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lokhttp3/MultipartBody$Part;",
            "Lokhttp3/RequestBody;",
            "Lokhttp3/RequestBody;",
            "Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;",
            "Ljava/lang/String;",
            ")",
            "Lretrofit2/Call<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3<",
            "Lcom/rokid/security/sdk/base/common/filesystem/FileUpdateBean;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/Multipart;
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/file/api/v1/upload"
    .end annotation
.end method

.method public abstract uploadPhoto(Lcom/rokid/security/sdk/ability/param/PhotoUploadRequest;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/sdk/ability/param/PhotoUploadRequest;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/ability/param/PhotoUploadRequest;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3<",
            "Ljava/lang/Object;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/flow/task/photoUpload"
    .end annotation
.end method

.method public abstract uploadPlateResult(Lcom/rokid/security/sdk/base/common/outside/SendResult;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/sdk/base/common/outside/SendResult;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/base/common/outside/SendResult;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/algorithm/api/smartglasses/vehicle"
    .end annotation
.end method

.method public abstract uploadVideo(Lcom/rokid/security/sdk/ability/param/VideoUploadRequest;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/sdk/ability/param/VideoUploadRequest;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/ability/param/VideoUploadRequest;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3<",
            "Ljava/lang/Object;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/flow/task/videoUpload"
    .end annotation
.end method
