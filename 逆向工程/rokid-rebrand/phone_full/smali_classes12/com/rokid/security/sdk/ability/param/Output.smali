.class public final Lcom/rokid/security/sdk/ability/param/Output;
.super Ljava/lang/Object;
.source "AsrIntent.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000&\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u000c\n\u0002\u0010\u000b\n\u0002\u0008\u0004\u0008\u0086\u0008\u0018\u00002\u00020\u0001B\u001d\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0005\u0012\u0006\u0010\u0006\u001a\u00020\u0007\u00a2\u0006\u0002\u0010\u0008J\t\u0010\u000f\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u0010\u001a\u00020\u0005H\u00c6\u0003J\t\u0010\u0011\u001a\u00020\u0007H\u00c6\u0003J\'\u0010\u0012\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u00052\u0008\u0008\u0002\u0010\u0006\u001a\u00020\u0007H\u00c6\u0001J\u0013\u0010\u0013\u001a\u00020\u00142\u0008\u0010\u0015\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010\u0016\u001a\u00020\u0003H\u00d6\u0001J\t\u0010\u0017\u001a\u00020\u0007H\u00d6\u0001R\u0016\u0010\u0006\u001a\u00020\u00078\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\t\u0010\nR\u0016\u0010\u0004\u001a\u00020\u00058\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000b\u0010\u000cR\u0016\u0010\u0002\u001a\u00020\u00038\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\r\u0010\u000e\u00a8\u0006\u0018"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/param/Output;",
        "",
        "status",
        "",
        "outputData",
        "Lcom/rokid/security/sdk/ability/param/OutputData;",
        "observation",
        "",
        "(ILcom/rokid/security/sdk/ability/param/OutputData;Ljava/lang/String;)V",
        "getObservation",
        "()Ljava/lang/String;",
        "getOutputData",
        "()Lcom/rokid/security/sdk/ability/param/OutputData;",
        "getStatus",
        "()I",
        "component1",
        "component2",
        "component3",
        "copy",
        "equals",
        "",
        "other",
        "hashCode",
        "toString",
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


# instance fields
.field private final observation:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "observation"
    .end annotation
.end field

.field private final outputData:Lcom/rokid/security/sdk/ability/param/OutputData;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "data"
    .end annotation
.end field

.field private final status:I
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "status"
    .end annotation
.end field


# direct methods
.method public constructor <init>(ILcom/rokid/security/sdk/ability/param/OutputData;Ljava/lang/String;)V
    .locals 1
    .param p1, "status"    # I
    .param p2, "outputData"    # Lcom/rokid/security/sdk/ability/param/OutputData;
    .param p3, "observation"    # Ljava/lang/String;

    const-string v0, "outputData"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "observation"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    iput p1, p0, Lcom/rokid/security/sdk/ability/param/Output;->status:I

    .line 31
    iput-object p2, p0, Lcom/rokid/security/sdk/ability/param/Output;->outputData:Lcom/rokid/security/sdk/ability/param/OutputData;

    .line 32
    iput-object p3, p0, Lcom/rokid/security/sdk/ability/param/Output;->observation:Ljava/lang/String;

    .line 29
    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/sdk/ability/param/Output;ILcom/rokid/security/sdk/ability/param/OutputData;Ljava/lang/String;ILjava/lang/Object;)Lcom/rokid/security/sdk/ability/param/Output;
    .locals 0

    and-int/lit8 p5, p4, 0x1

    if-eqz p5, :cond_0

    iget p1, p0, Lcom/rokid/security/sdk/ability/param/Output;->status:I

    :cond_0
    and-int/lit8 p5, p4, 0x2

    if-eqz p5, :cond_1

    iget-object p2, p0, Lcom/rokid/security/sdk/ability/param/Output;->outputData:Lcom/rokid/security/sdk/ability/param/OutputData;

    :cond_1
    and-int/lit8 p4, p4, 0x4

    if-eqz p4, :cond_2

    iget-object p3, p0, Lcom/rokid/security/sdk/ability/param/Output;->observation:Ljava/lang/String;

    :cond_2
    invoke-virtual {p0, p1, p2, p3}, Lcom/rokid/security/sdk/ability/param/Output;->copy(ILcom/rokid/security/sdk/ability/param/OutputData;Ljava/lang/String;)Lcom/rokid/security/sdk/ability/param/Output;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final component1()I
    .locals 1

    iget v0, p0, Lcom/rokid/security/sdk/ability/param/Output;->status:I

    return v0
.end method

.method public final component2()Lcom/rokid/security/sdk/ability/param/OutputData;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/Output;->outputData:Lcom/rokid/security/sdk/ability/param/OutputData;

    return-object v0
.end method

.method public final component3()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/Output;->observation:Ljava/lang/String;

    return-object v0
.end method

.method public final copy(ILcom/rokid/security/sdk/ability/param/OutputData;Ljava/lang/String;)Lcom/rokid/security/sdk/ability/param/Output;
    .locals 1

    const-string v0, "outputData"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "observation"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/security/sdk/ability/param/Output;

    invoke-direct {v0, p1, p2, p3}, Lcom/rokid/security/sdk/ability/param/Output;-><init>(ILcom/rokid/security/sdk/ability/param/OutputData;Ljava/lang/String;)V

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/sdk/ability/param/Output;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/sdk/ability/param/Output;

    iget v3, p0, Lcom/rokid/security/sdk/ability/param/Output;->status:I

    iget v4, v1, Lcom/rokid/security/sdk/ability/param/Output;->status:I

    if-eq v3, v4, :cond_2

    return v2

    :cond_2
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/Output;->outputData:Lcom/rokid/security/sdk/ability/param/OutputData;

    iget-object v4, v1, Lcom/rokid/security/sdk/ability/param/Output;->outputData:Lcom/rokid/security/sdk/ability/param/OutputData;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    return v2

    :cond_3
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/Output;->observation:Ljava/lang/String;

    iget-object v1, v1, Lcom/rokid/security/sdk/ability/param/Output;->observation:Ljava/lang/String;

    invoke-static {v3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    return v2

    :cond_4
    return v0
.end method

.method public final getObservation()Ljava/lang/String;
    .locals 1

    .line 32
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/Output;->observation:Ljava/lang/String;

    return-object v0
.end method

.method public final getOutputData()Lcom/rokid/security/sdk/ability/param/OutputData;
    .locals 1

    .line 31
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/Output;->outputData:Lcom/rokid/security/sdk/ability/param/OutputData;

    return-object v0
.end method

.method public final getStatus()I
    .locals 1

    .line 30
    iget v0, p0, Lcom/rokid/security/sdk/ability/param/Output;->status:I

    return v0
.end method

.method public hashCode()I
    .locals 3

    iget v0, p0, Lcom/rokid/security/sdk/ability/param/Output;->status:I

    invoke-static {v0}, Ljava/lang/Integer;->hashCode(I)I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/Output;->outputData:Lcom/rokid/security/sdk/ability/param/OutputData;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/param/OutputData;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/Output;->observation:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Output(status="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/security/sdk/ability/param/Output;->status:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", outputData="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/param/Output;->outputData:Lcom/rokid/security/sdk/ability/param/OutputData;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", observation="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/param/Output;->observation:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
