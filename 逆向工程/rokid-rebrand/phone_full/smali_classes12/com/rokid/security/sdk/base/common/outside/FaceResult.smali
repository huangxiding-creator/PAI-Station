.class public final Lcom/rokid/security/sdk/base/common/outside/FaceResult;
.super Ljava/lang/Object;
.source "LprResult.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000.\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0007\n\u0002\u0008\u001a\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0002\u0008\u0086\u0008\u0018\u00002\u00020\u0001B7\u0012\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u0003\u0012\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u0005\u0012\u0008\u0008\u0002\u0010\u0006\u001a\u00020\u0007\u0012\u0008\u0008\u0002\u0010\u0008\u001a\u00020\u0007\u0012\u0008\u0008\u0002\u0010\t\u001a\u00020\u0005\u00a2\u0006\u0002\u0010\nJ\t\u0010\u001b\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u001c\u001a\u00020\u0005H\u00c6\u0003J\t\u0010\u001d\u001a\u00020\u0007H\u00c6\u0003J\t\u0010\u001e\u001a\u00020\u0007H\u00c6\u0003J\t\u0010\u001f\u001a\u00020\u0005H\u00c6\u0003J;\u0010 \u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u00052\u0008\u0008\u0002\u0010\u0006\u001a\u00020\u00072\u0008\u0008\u0002\u0010\u0008\u001a\u00020\u00072\u0008\u0008\u0002\u0010\t\u001a\u00020\u0005H\u00c6\u0001J\u0013\u0010!\u001a\u00020\"2\u0008\u0010#\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010$\u001a\u00020%H\u00d6\u0001J\t\u0010&\u001a\u00020\u0005H\u00d6\u0001R\u001e\u0010\u0004\u001a\u00020\u00058\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000eR\u001e\u0010\u0006\u001a\u00020\u00078\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000f\u0010\u0010\"\u0004\u0008\u0011\u0010\u0012R\u001e\u0010\u0008\u001a\u00020\u00078\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u0010\"\u0004\u0008\u0014\u0010\u0012R\u001e\u0010\t\u001a\u00020\u00058\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0015\u0010\u000c\"\u0004\u0008\u0016\u0010\u000eR\u001e\u0010\u0002\u001a\u00020\u00038\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0017\u0010\u0018\"\u0004\u0008\u0019\u0010\u001a\u00a8\u0006\'"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/outside/FaceResult;",
        "",
        "time",
        "",
        "faceImage",
        "",
        "faceScore",
        "",
        "iqaScore",
        "reportName",
        "(JLjava/lang/String;FFLjava/lang/String;)V",
        "getFaceImage",
        "()Ljava/lang/String;",
        "setFaceImage",
        "(Ljava/lang/String;)V",
        "getFaceScore",
        "()F",
        "setFaceScore",
        "(F)V",
        "getIqaScore",
        "setIqaScore",
        "getReportName",
        "setReportName",
        "getTime",
        "()J",
        "setTime",
        "(J)V",
        "component1",
        "component2",
        "component3",
        "component4",
        "component5",
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
.field private faceImage:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "faceImage"
    .end annotation
.end field

.field private faceScore:F
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "faceScore"
    .end annotation
.end field

.field private iqaScore:F
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "iqaScore"
    .end annotation
.end field

.field private reportName:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "reportName"
    .end annotation
.end field

.field private time:J
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "time"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 9

    const/16 v7, 0x1f

    const/4 v8, 0x0

    const-wide/16 v1, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v0, p0

    invoke-direct/range {v0 .. v8}, Lcom/rokid/security/sdk/base/common/outside/FaceResult;-><init>(JLjava/lang/String;FFLjava/lang/String;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-void
.end method

.method public constructor <init>(JLjava/lang/String;FFLjava/lang/String;)V
    .locals 1
    .param p1, "time"    # J
    .param p3, "faceImage"    # Ljava/lang/String;
    .param p4, "faceScore"    # F
    .param p5, "iqaScore"    # F
    .param p6, "reportName"    # Ljava/lang/String;

    const-string v0, "faceImage"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "reportName"

    invoke-static {p6, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 51
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 52
    iput-wide p1, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->time:J

    .line 54
    iput-object p3, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceImage:Ljava/lang/String;

    .line 56
    iput p4, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceScore:F

    .line 58
    iput p5, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->iqaScore:F

    .line 60
    iput-object p6, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->reportName:Ljava/lang/String;

    .line 51
    return-void
.end method

.method public synthetic constructor <init>(JLjava/lang/String;FFLjava/lang/String;ILkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 7

    .line 51
    and-int/lit8 p8, p7, 0x1

    if-eqz p8, :cond_0

    .line 53
    const-wide/16 p1, 0x0

    move-wide v1, p1

    goto :goto_0

    .line 51
    :cond_0
    move-wide v1, p1

    :goto_0
    and-int/lit8 p1, p7, 0x2

    const-string p2, ""

    if-eqz p1, :cond_1

    .line 55
    move-object v3, p2

    goto :goto_1

    .line 51
    :cond_1
    move-object v3, p3

    :goto_1
    and-int/lit8 p1, p7, 0x4

    const/4 p3, 0x0

    if-eqz p1, :cond_2

    .line 57
    move v4, p3

    goto :goto_2

    .line 51
    :cond_2
    move v4, p4

    :goto_2
    and-int/lit8 p1, p7, 0x8

    if-eqz p1, :cond_3

    .line 59
    move v5, p3

    goto :goto_3

    .line 51
    :cond_3
    move v5, p5

    :goto_3
    and-int/lit8 p1, p7, 0x10

    if-eqz p1, :cond_4

    .line 61
    move-object v6, p2

    goto :goto_4

    .line 51
    :cond_4
    move-object v6, p6

    :goto_4
    move-object v0, p0

    invoke-direct/range {v0 .. v6}, Lcom/rokid/security/sdk/base/common/outside/FaceResult;-><init>(JLjava/lang/String;FFLjava/lang/String;)V

    .line 62
    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/sdk/base/common/outside/FaceResult;JLjava/lang/String;FFLjava/lang/String;ILjava/lang/Object;)Lcom/rokid/security/sdk/base/common/outside/FaceResult;
    .locals 7

    and-int/lit8 p8, p7, 0x1

    if-eqz p8, :cond_0

    iget-wide p1, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->time:J

    :cond_0
    move-wide v1, p1

    and-int/lit8 p1, p7, 0x2

    if-eqz p1, :cond_1

    iget-object p3, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceImage:Ljava/lang/String;

    :cond_1
    move-object v3, p3

    and-int/lit8 p1, p7, 0x4

    if-eqz p1, :cond_2

    iget p4, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceScore:F

    :cond_2
    move v4, p4

    and-int/lit8 p1, p7, 0x8

    if-eqz p1, :cond_3

    iget p5, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->iqaScore:F

    :cond_3
    move v5, p5

    and-int/lit8 p1, p7, 0x10

    if-eqz p1, :cond_4

    iget-object p6, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->reportName:Ljava/lang/String;

    :cond_4
    move-object v6, p6

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->copy(JLjava/lang/String;FFLjava/lang/String;)Lcom/rokid/security/sdk/base/common/outside/FaceResult;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final component1()J
    .locals 2

    iget-wide v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->time:J

    return-wide v0
.end method

.method public final component2()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceImage:Ljava/lang/String;

    return-object v0
.end method

.method public final component3()F
    .locals 1

    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceScore:F

    return v0
.end method

.method public final component4()F
    .locals 1

    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->iqaScore:F

    return v0
.end method

.method public final component5()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->reportName:Ljava/lang/String;

    return-object v0
.end method

.method public final copy(JLjava/lang/String;FFLjava/lang/String;)Lcom/rokid/security/sdk/base/common/outside/FaceResult;
    .locals 8

    const-string v0, "faceImage"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "reportName"

    invoke-static {p6, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;

    move-object v1, v0

    move-wide v2, p1

    move-object v4, p3

    move v5, p4

    move v6, p5

    move-object v7, p6

    invoke-direct/range {v1 .. v7}, Lcom/rokid/security/sdk/base/common/outside/FaceResult;-><init>(JLjava/lang/String;FFLjava/lang/String;)V

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 7

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/sdk/base/common/outside/FaceResult;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/sdk/base/common/outside/FaceResult;

    iget-wide v3, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->time:J

    iget-wide v5, v1, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->time:J

    cmp-long v3, v3, v5

    if-eqz v3, :cond_2

    return v2

    :cond_2
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceImage:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceImage:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    return v2

    :cond_3
    iget v3, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceScore:F

    iget v4, v1, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceScore:F

    invoke-static {v3, v4}, Ljava/lang/Float;->compare(FF)I

    move-result v3

    if-eqz v3, :cond_4

    return v2

    :cond_4
    iget v3, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->iqaScore:F

    iget v4, v1, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->iqaScore:F

    invoke-static {v3, v4}, Ljava/lang/Float;->compare(FF)I

    move-result v3

    if-eqz v3, :cond_5

    return v2

    :cond_5
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->reportName:Ljava/lang/String;

    iget-object v1, v1, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->reportName:Ljava/lang/String;

    invoke-static {v3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6

    return v2

    :cond_6
    return v0
.end method

.method public final getFaceImage()Ljava/lang/String;
    .locals 1

    .line 55
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceImage:Ljava/lang/String;

    return-object v0
.end method

.method public final getFaceScore()F
    .locals 1

    .line 57
    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceScore:F

    return v0
.end method

.method public final getIqaScore()F
    .locals 1

    .line 59
    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->iqaScore:F

    return v0
.end method

.method public final getReportName()Ljava/lang/String;
    .locals 1

    .line 61
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->reportName:Ljava/lang/String;

    return-object v0
.end method

.method public final getTime()J
    .locals 2

    .line 53
    iget-wide v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->time:J

    return-wide v0
.end method

.method public hashCode()I
    .locals 3

    iget-wide v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->time:J

    invoke-static {v0, v1}, Ljava/lang/Long;->hashCode(J)I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceImage:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget v2, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceScore:F

    invoke-static {v2}, Ljava/lang/Float;->hashCode(F)I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget v2, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->iqaScore:F

    invoke-static {v2}, Ljava/lang/Float;->hashCode(F)I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->reportName:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    return v0
.end method

.method public final setFaceImage(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 55
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceImage:Ljava/lang/String;

    return-void
.end method

.method public final setFaceScore(F)V
    .locals 0
    .param p1, "<set-?>"    # F

    .line 57
    iput p1, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceScore:F

    return-void
.end method

.method public final setIqaScore(F)V
    .locals 0
    .param p1, "<set-?>"    # F

    .line 59
    iput p1, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->iqaScore:F

    return-void
.end method

.method public final setReportName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 61
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->reportName:Ljava/lang/String;

    return-void
.end method

.method public final setTime(J)V
    .locals 0
    .param p1, "<set-?>"    # J

    .line 53
    iput-wide p1, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->time:J

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "FaceResult(time="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->time:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", faceImage="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceImage:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", faceScore="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->faceScore:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", iqaScore="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->iqaScore:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", reportName="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/FaceResult;->reportName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
