.class final Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1$ret$1;
.super Lkotlin/jvm/internal/Lambda;
.source "OfflineRecgManger.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function0;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function0<",
        "Lkotlinx/coroutines/flow/Flow<",
        "+",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
        "Ljava/util/List<",
        "+",
        "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
        ">;>;>;>;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0000\u0010\u0000\u001a\u0014\u0012\u0010\u0012\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00040\u00030\u00020\u0001H\n\u00a2\u0006\u0002\u0008\u0005"
    }
    d2 = {
        "<anonymous>",
        "Lkotlinx/coroutines/flow/Flow;",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;",
        "",
        "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
        "invoke"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic $libScenes:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $sn:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/util/ArrayList;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1$ret$1;->$sn:Ljava/lang/String;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1$ret$1;->$libScenes:Ljava/util/ArrayList;

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke()Ljava/lang/Object;
    .locals 1

    .line 152
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1$ret$1;->invoke()Lkotlinx/coroutines/flow/Flow;

    move-result-object v0

    return-object v0
.end method

.method public final invoke()Lkotlinx/coroutines/flow/Flow;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
            ">;>;>;"
        }
    .end annotation

    .line 153
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->access$getMRepository$p()Lcom/rokid/security/phone/sdk/server/recog/offline/repository/OfflineRecRepository;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1$ret$1;->$sn:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1$ret$1;->$libScenes:Ljava/util/ArrayList;

    check-cast v2, Ljava/util/List;

    const-string v3, "128-ncnn"

    invoke-virtual {v0, v1, v3, v2}, Lcom/rokid/security/phone/sdk/server/recog/offline/repository/OfflineRecRepository;->getPersonnelLib(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;)Lkotlinx/coroutines/flow/Flow;

    move-result-object v0

    return-object v0
.end method
