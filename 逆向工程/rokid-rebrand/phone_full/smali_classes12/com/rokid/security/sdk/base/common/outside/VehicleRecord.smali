.class public final Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;
.super Ljava/lang/Object;
.source "VehicleInfo.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000,\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u000e\n\u0002\u0010\u000b\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0000\u0008\u0086\u0008\u0018\u00002\u00020\u0001B+\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0003\u0012\u000c\u0010\u0005\u001a\u0008\u0012\u0004\u0012\u00020\u00070\u0006\u0012\u0006\u0010\u0008\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\tJ\t\u0010\u0010\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u0011\u001a\u00020\u0003H\u00c6\u0003J\u000f\u0010\u0012\u001a\u0008\u0012\u0004\u0012\u00020\u00070\u0006H\u00c6\u0003J\t\u0010\u0013\u001a\u00020\u0003H\u00c6\u0003J7\u0010\u0014\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u00032\u000e\u0008\u0002\u0010\u0005\u001a\u0008\u0012\u0004\u0012\u00020\u00070\u00062\u0008\u0008\u0002\u0010\u0008\u001a\u00020\u0003H\u00c6\u0001J\u0013\u0010\u0015\u001a\u00020\u00162\u0008\u0010\u0017\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010\u0018\u001a\u00020\u0003H\u00d6\u0001J\t\u0010\u0019\u001a\u00020\u001aH\u00d6\u0001R\u0016\u0010\u0008\u001a\u00020\u00038\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\n\u0010\u000bR\u0016\u0010\u0004\u001a\u00020\u00038\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000c\u0010\u000bR\u001c\u0010\u0005\u001a\u0008\u0012\u0004\u0012\u00020\u00070\u00068\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\r\u0010\u000eR\u0016\u0010\u0002\u001a\u00020\u00038\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000f\u0010\u000b\u00a8\u0006\u001b"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;",
        "",
        "total",
        "",
        "pageSize",
        "rows",
        "",
        "Lcom/rokid/security/sdk/base/common/outside/VehicleRecordDetail;",
        "pageNum",
        "(IILjava/util/List;I)V",
        "getPageNum",
        "()I",
        "getPageSize",
        "getRows",
        "()Ljava/util/List;",
        "getTotal",
        "component1",
        "component2",
        "component3",
        "component4",
        "copy",
        "equals",
        "",
        "other",
        "hashCode",
        "toString",
        "",
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
.field private final pageNum:I
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "pageNum"
    .end annotation
.end field

.field private final pageSize:I
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "pageSize"
    .end annotation
.end field

.field private final rows:Ljava/util/List;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "rows"
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/VehicleRecordDetail;",
            ">;"
        }
    .end annotation
.end field

.field private final total:I
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "total"
    .end annotation
.end field


# direct methods
.method public constructor <init>(IILjava/util/List;I)V
    .locals 1
    .param p1, "total"    # I
    .param p2, "pageSize"    # I
    .param p3, "rows"    # Ljava/util/List;
    .param p4, "pageNum"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(II",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/VehicleRecordDetail;",
            ">;I)V"
        }
    .end annotation

    const-string/jumbo v0, "rows"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 106
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 107
    iput p1, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->total:I

    .line 109
    iput p2, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->pageSize:I

    .line 111
    iput-object p3, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->rows:Ljava/util/List;

    .line 113
    iput p4, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->pageNum:I

    .line 106
    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;IILjava/util/List;IILjava/lang/Object;)Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;
    .locals 0

    and-int/lit8 p6, p5, 0x1

    if-eqz p6, :cond_0

    iget p1, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->total:I

    :cond_0
    and-int/lit8 p6, p5, 0x2

    if-eqz p6, :cond_1

    iget p2, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->pageSize:I

    :cond_1
    and-int/lit8 p6, p5, 0x4

    if-eqz p6, :cond_2

    iget-object p3, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->rows:Ljava/util/List;

    :cond_2
    and-int/lit8 p5, p5, 0x8

    if-eqz p5, :cond_3

    iget p4, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->pageNum:I

    :cond_3
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->copy(IILjava/util/List;I)Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final component1()I
    .locals 1

    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->total:I

    return v0
.end method

.method public final component2()I
    .locals 1

    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->pageSize:I

    return v0
.end method

.method public final component3()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/VehicleRecordDetail;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->rows:Ljava/util/List;

    return-object v0
.end method

.method public final component4()I
    .locals 1

    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->pageNum:I

    return v0
.end method

.method public final copy(IILjava/util/List;I)Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(II",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/VehicleRecordDetail;",
            ">;I)",
            "Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;"
        }
    .end annotation

    const-string/jumbo v0, "rows"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;

    invoke-direct {v0, p1, p2, p3, p4}, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;-><init>(IILjava/util/List;I)V

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;

    iget v3, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->total:I

    iget v4, v1, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->total:I

    if-eq v3, v4, :cond_2

    return v2

    :cond_2
    iget v3, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->pageSize:I

    iget v4, v1, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->pageSize:I

    if-eq v3, v4, :cond_3

    return v2

    :cond_3
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->rows:Ljava/util/List;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->rows:Ljava/util/List;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_4

    return v2

    :cond_4
    iget v3, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->pageNum:I

    iget v1, v1, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->pageNum:I

    if-eq v3, v1, :cond_5

    return v2

    :cond_5
    return v0
.end method

.method public final getPageNum()I
    .locals 1

    .line 114
    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->pageNum:I

    return v0
.end method

.method public final getPageSize()I
    .locals 1

    .line 110
    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->pageSize:I

    return v0
.end method

.method public final getRows()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/VehicleRecordDetail;",
            ">;"
        }
    .end annotation

    .line 112
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->rows:Ljava/util/List;

    return-object v0
.end method

.method public final getTotal()I
    .locals 1

    .line 108
    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->total:I

    return v0
.end method

.method public hashCode()I
    .locals 3

    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->total:I

    invoke-static {v0}, Ljava/lang/Integer;->hashCode(I)I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget v2, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->pageSize:I

    invoke-static {v2}, Ljava/lang/Integer;->hashCode(I)I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->rows:Ljava/util/List;

    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget v2, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->pageNum:I

    invoke-static {v2}, Ljava/lang/Integer;->hashCode(I)I

    move-result v2

    add-int/2addr v1, v2

    return v1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "VehicleRecord(total="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->total:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", pageSize="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->pageSize:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", rows="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->rows:Ljava/util/List;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", pageNum="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/security/sdk/base/common/outside/VehicleRecord;->pageNum:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
