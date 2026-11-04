.class public final Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;
.super Ljava/lang/Object;
.source "VehicleInfo.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\r\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0002\u0008\u0086\u0008\u0018\u00002\u00020\u0001B\u001d\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0003\u0012\u0006\u0010\u0005\u001a\u00020\u0006\u00a2\u0006\u0002\u0010\u0007J\t\u0010\u000f\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u0010\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u0011\u001a\u00020\u0006H\u00c6\u0003J\'\u0010\u0012\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0005\u001a\u00020\u0006H\u00c6\u0001J\u0013\u0010\u0013\u001a\u00020\u00142\u0008\u0010\u0015\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010\u0016\u001a\u00020\u0017H\u00d6\u0001J\t\u0010\u0018\u001a\u00020\u0003H\u00d6\u0001R\u0016\u0010\u0005\u001a\u00020\u00068\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0008\u0010\tR\u0016\u0010\u0002\u001a\u00020\u00038\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\n\u0010\u000bR\u001e\u0010\u0004\u001a\u00020\u00038\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000c\u0010\u000b\"\u0004\u0008\r\u0010\u000e\u00a8\u0006\u0019"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;",
        "",
        "id",
        "",
        "operate",
        "appVO",
        "Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;",
        "(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;)V",
        "getAppVO",
        "()Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;",
        "getId",
        "()Ljava/lang/String;",
        "getOperate",
        "setOperate",
        "(Ljava/lang/String;)V",
        "component1",
        "component2",
        "component3",
        "copy",
        "equals",
        "",
        "other",
        "hashCode",
        "",
        "toString",
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
.field private final appVO:Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "appVO"
    .end annotation
.end field

.field private final id:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "id"
    .end annotation
.end field

.field private operate:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "operate"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;)V
    .locals 1
    .param p1, "id"    # Ljava/lang/String;
    .param p2, "operate"    # Ljava/lang/String;
    .param p3, "appVO"    # Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;

    const-string v0, "id"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "operate"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "appVO"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 72
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 73
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->id:Ljava/lang/String;

    .line 75
    iput-object p2, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->operate:Ljava/lang/String;

    .line 77
    iput-object p3, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->appVO:Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;

    .line 72
    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;ILjava/lang/Object;)Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;
    .locals 0

    and-int/lit8 p5, p4, 0x1

    if-eqz p5, :cond_0

    iget-object p1, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->id:Ljava/lang/String;

    :cond_0
    and-int/lit8 p5, p4, 0x2

    if-eqz p5, :cond_1

    iget-object p2, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->operate:Ljava/lang/String;

    :cond_1
    and-int/lit8 p4, p4, 0x4

    if-eqz p4, :cond_2

    iget-object p3, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->appVO:Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;

    :cond_2
    invoke-virtual {p0, p1, p2, p3}, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->copy(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;)Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final component1()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->id:Ljava/lang/String;

    return-object v0
.end method

.method public final component2()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->operate:Ljava/lang/String;

    return-object v0
.end method

.method public final component3()Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->appVO:Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;

    return-object v0
.end method

.method public final copy(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;)Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;
    .locals 1

    const-string v0, "id"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "operate"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "appVO"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;

    invoke-direct {v0, p1, p2, p3}, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;)V

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;

    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->id:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->id:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    return v2

    :cond_2
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->operate:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->operate:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    return v2

    :cond_3
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->appVO:Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;

    iget-object v1, v1, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->appVO:Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;

    invoke-static {v3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    return v2

    :cond_4
    return v0
.end method

.method public final getAppVO()Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;
    .locals 1

    .line 78
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->appVO:Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;

    return-object v0
.end method

.method public final getId()Ljava/lang/String;
    .locals 1

    .line 74
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->id:Ljava/lang/String;

    return-object v0
.end method

.method public final getOperate()Ljava/lang/String;
    .locals 1

    .line 76
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->operate:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 3

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->id:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->operate:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->appVO:Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    return v0
.end method

.method public final setOperate(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 76
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->operate:Ljava/lang/String;

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "VehicleOperation(id="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->id:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", operate="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->operate:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", appVO="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleOperation;->appVO:Lcom/rokid/security/sdk/base/common/outside/VehicleInfo1;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
