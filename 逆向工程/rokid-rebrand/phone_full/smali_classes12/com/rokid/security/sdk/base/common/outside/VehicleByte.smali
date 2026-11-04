.class public final Lcom/rokid/security/sdk/base/common/outside/VehicleByte;
.super Ljava/lang/Object;
.source "VehicleInfo.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001a\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0010\u0012\n\u0002\u0008\u0008\u0018\u00002\u00020\u0001B%\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0003\u0012\u0006\u0010\u0005\u001a\u00020\u0003\u0012\u0006\u0010\u0006\u001a\u00020\u0007\u00a2\u0006\u0002\u0010\u0008R\u0011\u0010\u0006\u001a\u00020\u0007\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\t\u0010\nR\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000b\u0010\u000cR\u0011\u0010\u0004\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\r\u0010\u000cR\u0011\u0010\u0005\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000e\u0010\u000c\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/outside/VehicleByte;",
        "",
        "libId",
        "",
        "libName",
        "operateType",
        "dataList",
        "",
        "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V",
        "getDataList",
        "()[B",
        "getLibId",
        "()Ljava/lang/String;",
        "getLibName",
        "getOperateType",
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
.field private final dataList:[B

.field private final libId:Ljava/lang/String;

.field private final libName:Ljava/lang/String;

.field private final operateType:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V
    .locals 1
    .param p1, "libId"    # Ljava/lang/String;
    .param p2, "libName"    # Ljava/lang/String;
    .param p3, "operateType"    # Ljava/lang/String;
    .param p4, "dataList"    # [B

    const-string v0, "libId"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "libName"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "operateType"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "dataList"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 90
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 91
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleByte;->libId:Ljava/lang/String;

    .line 92
    iput-object p2, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleByte;->libName:Ljava/lang/String;

    .line 93
    iput-object p3, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleByte;->operateType:Ljava/lang/String;

    .line 94
    iput-object p4, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleByte;->dataList:[B

    .line 90
    return-void
.end method


# virtual methods
.method public final getDataList()[B
    .locals 1

    .line 94
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleByte;->dataList:[B

    return-object v0
.end method

.method public final getLibId()Ljava/lang/String;
    .locals 1

    .line 91
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleByte;->libId:Ljava/lang/String;

    return-object v0
.end method

.method public final getLibName()Ljava/lang/String;
    .locals 1

    .line 92
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleByte;->libName:Ljava/lang/String;

    return-object v0
.end method

.method public final getOperateType()Ljava/lang/String;
    .locals 1

    .line 93
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleByte;->operateType:Ljava/lang/String;

    return-object v0
.end method
