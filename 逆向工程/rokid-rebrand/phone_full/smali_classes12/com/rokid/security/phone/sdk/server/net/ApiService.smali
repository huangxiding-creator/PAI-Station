.class public interface abstract Lcom/rokid/security/phone/sdk/server/net/ApiService;
.super Ljava/lang/Object;
.source "ApiService.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/server/net/ApiService$Companion;,
        Lcom/rokid/security/phone/sdk/server/net/ApiService$DefaultImpls;,
        Lcom/rokid/security/phone/sdk/server/net/ApiService$Headers;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u00dc\u0001\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008f\u0018\u0000 D2\u00020\u0001:\u0002DEJ\u001e\u0010\u0002\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00050\u00040\u00032\u0008\u0008\u0001\u0010\u0006\u001a\u00020\u0007H\'J\u001e\u0010\u0008\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\t0\u00040\u00032\u0008\u0008\u0001\u0010\u0006\u001a\u00020\nH\'J\u001e\u0010\u000b\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00050\u00040\u00032\u0008\u0008\u0001\u0010\u0006\u001a\u00020\u000cH\'J\u001e\u0010\r\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u000e0\u00040\u00032\u0008\u0008\u0001\u0010\u000f\u001a\u00020\u0010H\'J\u0014\u0010\u0011\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00130\u00120\u0003H\'J\u0014\u0010\u0014\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00150\u00120\u0003H\'J:\u0010\u0016\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00170\u00120\u00032$\u0008\u0001\u0010\u0018\u001a\u001e\u0012\u0004\u0012\u00020\u0010\u0012\u0004\u0012\u00020\u00100\u0019j\u000e\u0012\u0004\u0012\u00020\u0010\u0012\u0004\u0012\u00020\u0010`\u001aH\'J$\u0010\u001b\u001a\u0014\u0012\u0010\u0012\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u001d0\u001c0\u00120\u00032\u0008\u0008\u0001\u0010\u0006\u001a\u00020\u001eH\'J\u001a\u0010\u001f\u001a\u0014\u0012\u0010\u0012\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020 0\u001c0\u00120\u0003H\'J\u0014\u0010!\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\t0\u00040\u0003H\'J,\u0010\"\u001a\u0008\u0012\u0004\u0012\u00020#0\u00032\u0008\u0008\u0001\u0010\u000f\u001a\u00020\u00102\u0008\u0008\u0001\u0010$\u001a\u00020\u00102\u0008\u0008\u0001\u0010\u0006\u001a\u00020%H\'J\u001e\u0010&\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\'0\u00120\u00032\u0008\u0008\u0001\u0010\u0006\u001a\u00020(H\'J$\u0010)\u001a\u0014\u0012\u0010\u0012\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020*0\u001c0\u00120\u00032\u0008\u0008\u0001\u0010\u0006\u001a\u00020+H\'J\u001e\u0010,\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020-0\u00040\u00032\u0008\u0008\u0001\u0010\u0006\u001a\u00020.H\'J\u001e\u0010/\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002000\u00040\u00032\u0008\u0008\u0001\u0010\u0006\u001a\u000201H\'JH\u00102\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002040\u0004032\u0008\u0008\u0001\u00105\u001a\u0002062\n\u0008\u0003\u00107\u001a\u0004\u0018\u0001082\u0008\u0008\u0001\u00109\u001a\u0002082\u0008\u0008\u0001\u0010:\u001a\u00020;2\u0008\u0008\u0001\u0010$\u001a\u00020\u0010H\'J\u001e\u0010<\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00010\u00040\u00032\u0008\u0008\u0001\u0010=\u001a\u00020>H\'J\u001e\u0010?\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00010\u00040\u00032\u0008\u0008\u0001\u0010=\u001a\u00020@H\'J(\u0010A\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020B0\u00120\u00032\u0008\u0008\u0001\u0010\u0006\u001a\u00020C2\u0008\u0008\u0001\u0010$\u001a\u00020\u0010H\'\u00a8\u0006F"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/net/ApiService;",
        "",
        "aiWorkAssistantBegin",
        "Lkotlinx/coroutines/flow/Flow;",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;",
        "Lcom/rokid/security/phone/sdk/server/asr/AsrIntent;",
        "param",
        "Lcom/rokid/security/phone/sdk/server/aiwork/AiWorkAssistantBeginRequestParam;",
        "aiWorkAssistantCompelet",
        "",
        "Lcom/rokid/security/phone/sdk/server/aiwork/AiWorkAssistantEndRequestParam;",
        "asrIntent",
        "Lcom/rokid/security/phone/sdk/server/asr/AsrRequestParam;",
        "getAppDownloadInfo",
        "Lcom/rokid/security/sdk/base/common/filedownload/AppDownloadInfo;",
        "url",
        "",
        "getAppListConfig",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;",
        "Lcom/rokid/security/sdk/base/common/market/AppData;",
        "getLauncherConfig",
        "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherRootBean;",
        "getPersonnelInfo",
        "Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;",
        "map",
        "Ljava/util/HashMap;",
        "Lkotlin/collections/HashMap;",
        "getPersonnelLib",
        "",
        "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
        "Lcom/rokid/security/phone/sdk/server/recog/offline/param/LibraryParam;",
        "getSwitchConfig",
        "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/SwitchHot;",
        "identificationEnd",
        "otaCheck",
        "Lcom/rokid/security/sdk/base/common/ota/OTAResponse;",
        "token",
        "Lcom/rokid/security/sdk/base/common/ota/SystemInfo;",
        "personCheck",
        "Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;",
        "Lcom/rokid/security/phone/sdk/server/recog/online/param/PersonCheckParam;",
        "recognize",
        "Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;",
        "Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;",
        "refreshToken",
        "Lcom/rokid/security/sdk/base/common/auth/SdkToken;",
        "Lcom/rokid/security/sdk/base/common/auth/SdkTokenRequest;",
        "toIntent",
        "Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;",
        "Lcom/rokid/security/phone/sdk/server/aichat/data/IntentParam;",
        "uploadFile",
        "Lretrofit2/Call;",
        "Lcom/rokid/security/sdk/base/common/filesystem/FileUpdateBean;",
        "file",
        "Lokhttp3/MultipartBody$Part;",
        "tag",
        "Lokhttp3/RequestBody;",
        "personId",
        "deviceMeta",
        "Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;",
        "uploadPhoto",
        "request",
        "Lcom/rokid/security/phone/sdk/server/inspection/PhotoUploadRequest;",
        "uploadVideo",
        "Lcom/rokid/security/phone/sdk/server/inspection/VideoUploadRequest;",
        "vehicleCheck",
        "Lcom/rokid/security/sdk/base/common/out/VehicleCheckInfo;",
        "Lcom/rokid/security/phone/sdk/server/recog/online/param/VehicleCheckParam;",
        "Companion",
        "Headers",
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
.field public static final Companion:Lcom/rokid/security/phone/sdk/server/net/ApiService$Companion;

.field public static final TOKEN:Ljava/lang/String; = "Authorization"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Lcom/rokid/security/phone/sdk/server/net/ApiService$Companion;->$$INSTANCE:Lcom/rokid/security/phone/sdk/server/net/ApiService$Companion;

    sput-object v0, Lcom/rokid/security/phone/sdk/server/net/ApiService;->Companion:Lcom/rokid/security/phone/sdk/server/net/ApiService$Companion;

    return-void
.end method


# virtual methods
.method public abstract aiWorkAssistantBegin(Lcom/rokid/security/phone/sdk/server/aiwork/AiWorkAssistantBeginRequestParam;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/phone/sdk/server/aiwork/AiWorkAssistantBeginRequestParam;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/aiwork/AiWorkAssistantBeginRequestParam;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3<",
            "Lcom/rokid/security/phone/sdk/server/asr/AsrIntent;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/flow/task/start"
    .end annotation
.end method

.method public abstract aiWorkAssistantCompelet(Lcom/rokid/security/phone/sdk/server/aiwork/AiWorkAssistantEndRequestParam;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/phone/sdk/server/aiwork/AiWorkAssistantEndRequestParam;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/aiwork/AiWorkAssistantEndRequestParam;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3<",
            "Ljava/lang/Boolean;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/flow/task/end"
    .end annotation
.end method

.method public abstract asrIntent(Lcom/rokid/security/phone/sdk/server/asr/AsrRequestParam;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/phone/sdk/server/asr/AsrRequestParam;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/asr/AsrRequestParam;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3<",
            "Lcom/rokid/security/phone/sdk/server/asr/AsrIntent;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/assistant/api/v2/intent"
    .end annotation
.end method

.method public abstract getAppDownloadInfo(Ljava/lang/String;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit2/http/Url;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3<",
            "Lcom/rokid/security/sdk/base/common/filedownload/AppDownloadInfo;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/GET;
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

.method public abstract getLauncherConfig()Lkotlinx/coroutines/flow/Flow;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherRootBean;",
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

.method public abstract getPersonnelLib(Lcom/rokid/security/phone/sdk/server/recog/offline/param/LibraryParam;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/phone/sdk/server/recog/offline/param/LibraryParam;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/recog/offline/param/LibraryParam;",
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

.method public abstract getSwitchConfig()Lkotlinx/coroutines/flow/Flow;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Ljava/util/List<",
            "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/SwitchHot;",
            ">;>;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/GET;
        value = "/ar/flow/api/v1/glassConfig/switch"
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

.method public abstract personCheck(Lcom/rokid/security/phone/sdk/server/recog/online/param/PersonCheckParam;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/phone/sdk/server/recog/online/param/PersonCheckParam;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/recog/online/param/PersonCheckParam;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/api/ai/algorithm/person/background"
    .end annotation
.end method

.method public abstract recognize(Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;",
            ">;>;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/algorithm/api/person/face/recognize"
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

.method public abstract toIntent(Lcom/rokid/security/phone/sdk/server/aichat/data/IntentParam;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/phone/sdk/server/aichat/data/IntentParam;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/aichat/data/IntentParam;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3<",
            "Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/assistant/api/v1/intent"
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

.method public abstract uploadPhoto(Lcom/rokid/security/phone/sdk/server/inspection/PhotoUploadRequest;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/phone/sdk/server/inspection/PhotoUploadRequest;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/inspection/PhotoUploadRequest;",
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

.method public abstract uploadVideo(Lcom/rokid/security/phone/sdk/server/inspection/VideoUploadRequest;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/phone/sdk/server/inspection/VideoUploadRequest;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/inspection/VideoUploadRequest;",
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

.method public abstract vehicleCheck(Lcom/rokid/security/phone/sdk/server/recog/online/param/VehicleCheckParam;Ljava/lang/String;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/phone/sdk/server/recog/online/param/VehicleCheckParam;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit2/http/Header;
            value = "Authorization"
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/recog/online/param/VehicleCheckParam;",
            "Ljava/lang/String;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Lcom/rokid/security/sdk/base/common/out/VehicleCheckInfo;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/api/algorithm/vehicle/background"
    .end annotation
.end method
