.class public final Lcom/rokid/security/sdk/base/common/outside/VehiclePlateInfo;
.super Ljava/lang/Object;
.source "VehicleInfo.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001e\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010 \n\u0002\u0008\u0008\u0018\u00002\u00020\u0001B%\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u0005\u0012\u000c\u0010\u0006\u001a\u0008\u0012\u0004\u0012\u00020\u00030\u0007\u00a2\u0006\u0002\u0010\u0008R\u0016\u0010\u0004\u001a\u00020\u00058\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\t\u0010\nR\u001c\u0010\u0006\u001a\u0008\u0012\u0004\u0012\u00020\u00030\u00078\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000b\u0010\u000cR\u0016\u0010\u0002\u001a\u00020\u00038\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\r\u0010\u000e\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/outside/VehiclePlateInfo;",
        "",
        "operateType",
        "",
        "count",
        "",
        "dataList",
        "",
        "(Ljava/lang/String;ILjava/util/List;)V",
        "getCount",
        "()I",
        "getDataList",
        "()Ljava/util/List;",
        "getOperateType",
        "()Ljava/lang/String;",
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
.field private final count:I
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "count"
    .end annotation
.end field

.field private final dataList:Ljava/util/List;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "dataList"
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final operateType:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "operateType"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;ILjava/util/List;)V
    .locals 1
    .param p1, "operateType"    # Ljava/lang/String;
    .param p2, "count"    # I
    .param p3, "dataList"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "I",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const-string v0, "operateType"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "dataList"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 97
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 98
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/outside/VehiclePlateInfo;->operateType:Ljava/lang/String;

    .line 100
    iput p2, p0, Lcom/rokid/security/sdk/base/common/outside/VehiclePlateInfo;->count:I

    .line 102
    iput-object p3, p0, Lcom/rokid/security/sdk/base/common/outside/VehiclePlateInfo;->dataList:Ljava/util/List;

    .line 97
    return-void
.end method

.method public synthetic constructor <init>(Ljava/lang/String;ILjava/util/List;ILkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    .line 97
    and-int/lit8 p4, p4, 0x2

    if-eqz p4, :cond_0

    .line 101
    const/4 p2, -0x1

    .line 97
    :cond_0
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/sdk/base/common/outside/VehiclePlateInfo;-><init>(Ljava/lang/String;ILjava/util/List;)V

    .line 104
    return-void
.end method


# virtual methods
.method public final getCount()I
    .locals 1

    .line 101
    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehiclePlateInfo;->count:I

    return v0
.end method

.method public final getDataList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 103
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehiclePlateInfo;->dataList:Ljava/util/List;

    return-object v0
.end method

.method public final getOperateType()Ljava/lang/String;
    .locals 1

    .line 99
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehiclePlateInfo;->operateType:Ljava/lang/String;

    return-object v0
.end method
