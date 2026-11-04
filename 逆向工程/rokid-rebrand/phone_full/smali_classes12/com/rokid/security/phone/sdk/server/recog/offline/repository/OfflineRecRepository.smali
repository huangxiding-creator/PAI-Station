.class public final Lcom/rokid/security/phone/sdk/server/recog/offline/repository/OfflineRecRepository;
.super Ljava/lang/Object;
.source "OfflineRecRepository.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000,\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0004\u0008\u0000\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u001a\u0010\u0003\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00060\u00050\u00042\u0006\u0010\u0007\u001a\u00020\u0008J6\u0010\t\u001a\u0014\u0012\u0010\u0012\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u000b0\n0\u00050\u00042\u0006\u0010\u000c\u001a\u00020\u00082\u0006\u0010\r\u001a\u00020\u00082\u000c\u0010\u000e\u001a\u0008\u0012\u0004\u0012\u00020\u00080\n\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/recog/offline/repository/OfflineRecRepository;",
        "",
        "()V",
        "getPersonnelInfo",
        "Lkotlinx/coroutines/flow/Flow;",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;",
        "Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;",
        "personnelId",
        "",
        "getPersonnelLib",
        "",
        "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
        "sn",
        "algorithmVersion",
        "libScenes",
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

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getPersonnelInfo(Ljava/lang/String;)Lkotlinx/coroutines/flow/Flow;
    .locals 4
    .param p1, "personnelId"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;",
            ">;>;"
        }
    .end annotation

    const-string v0, "personnelId"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 30
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    move-object v2, v1

    .local v2, "$this$getPersonnelInfo_u24lambda_u240":Ljava/util/HashMap;
    const/4 v3, 0x0

    .line 31
    .local v3, "$i$a$-apply-OfflineRecRepository$getPersonnelInfo$param$1":I
    invoke-virtual {v2, v0, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 32
    nop

    .line 30
    .end local v2    # "$this$getPersonnelInfo_u24lambda_u240":Ljava/util/HashMap;
    .end local v3    # "$i$a$-apply-OfflineRecRepository$getPersonnelInfo$param$1":I
    move-object v0, v1

    .line 33
    .local v0, "param":Ljava/util/HashMap;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->INSTANCE:Lcom/rokid/security/phone/sdk/server/net/ApiProvider;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->getApi()Lcom/rokid/security/phone/sdk/server/net/ApiService;

    move-result-object v1

    invoke-interface {v1, v0}, Lcom/rokid/security/phone/sdk/server/net/ApiService;->getPersonnelInfo(Ljava/util/HashMap;)Lkotlinx/coroutines/flow/Flow;

    move-result-object v1

    return-object v1
.end method

.method public final getPersonnelLib(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;)Lkotlinx/coroutines/flow/Flow;
    .locals 2
    .param p1, "sn"    # Ljava/lang/String;
    .param p2, "algorithmVersion"    # Ljava/lang/String;
    .param p3, "libScenes"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
            ">;>;>;"
        }
    .end annotation

    const-string/jumbo v0, "sn"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "algorithmVersion"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "libScenes"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    new-instance v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/LibraryParam;

    const-string/jumbo v1, "zl"

    invoke-direct {v0, p1, p2, v1, p3}, Lcom/rokid/security/phone/sdk/server/recog/offline/param/LibraryParam;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;)V

    .line 20
    .local v0, "param":Lcom/rokid/security/phone/sdk/server/recog/offline/param/LibraryParam;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->INSTANCE:Lcom/rokid/security/phone/sdk/server/net/ApiProvider;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->getApi()Lcom/rokid/security/phone/sdk/server/net/ApiService;

    move-result-object v1

    invoke-interface {v1, v0}, Lcom/rokid/security/phone/sdk/server/net/ApiService;->getPersonnelLib(Lcom/rokid/security/phone/sdk/server/recog/offline/param/LibraryParam;)Lkotlinx/coroutines/flow/Flow;

    move-result-object v1

    return-object v1
.end method
