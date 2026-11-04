.class public final Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;
.super Ljava/lang/Object;
.source "ImageCollectModel.kt"

# interfaces
.implements Landroid/os/Parcelable;


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000:\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0007\n\u0002\u0008\t\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0008\u0087\u0008\u0018\u00002\u00020\u0001B\u0015\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0005J\t\u0010\t\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\n\u001a\u00020\u0003H\u00c6\u0003J\u001d\u0010\u000b\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u0003H\u00c6\u0001J\t\u0010\u000c\u001a\u00020\rH\u00d6\u0001J\u0013\u0010\u000e\u001a\u00020\u000f2\u0008\u0010\u0010\u001a\u0004\u0018\u00010\u0011H\u00d6\u0003J\t\u0010\u0012\u001a\u00020\rH\u00d6\u0001J\t\u0010\u0013\u001a\u00020\u0014H\u00d6\u0001J\u0019\u0010\u0015\u001a\u00020\u00162\u0006\u0010\u0017\u001a\u00020\u00182\u0006\u0010\u0019\u001a\u00020\rH\u00d6\u0001R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0006\u0010\u0007R\u0011\u0010\u0004\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0008\u0010\u0007\u00a8\u0006\u001a"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;",
        "Landroid/os/Parcelable;",
        "faceScore",
        "",
        "iqaScore",
        "(FF)V",
        "getFaceScore",
        "()F",
        "getIqaScore",
        "component1",
        "component2",
        "copy",
        "describeContents",
        "",
        "equals",
        "",
        "other",
        "",
        "hashCode",
        "toString",
        "",
        "writeToParcel",
        "",
        "parcel",
        "Landroid/os/Parcel;",
        "flags",
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


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final faceScore:F

.field private final iqaScore:F


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo$Creator;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo$Creator;-><init>()V

    check-cast v0, Landroid/os/Parcelable$Creator;

    sput-object v0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>(FF)V
    .locals 0
    .param p1, "faceScore"    # F
    .param p2, "iqaScore"    # F

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 22
    iput p1, p0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->faceScore:F

    .line 23
    iput p2, p0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->iqaScore:F

    .line 21
    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;FFILjava/lang/Object;)Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;
    .locals 0

    and-int/lit8 p4, p3, 0x1

    if-eqz p4, :cond_0

    iget p1, p0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->faceScore:F

    :cond_0
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_1

    iget p2, p0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->iqaScore:F

    :cond_1
    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->copy(FF)Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final component1()F
    .locals 1

    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->faceScore:F

    return v0
.end method

.method public final component2()F
    .locals 1

    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->iqaScore:F

    return v0
.end method

.method public final copy(FF)Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;

    invoke-direct {v0, p1, p2}, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;-><init>(FF)V

    return-object v0
.end method

.method public describeContents()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;

    iget v3, p0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->faceScore:F

    iget v4, v1, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->faceScore:F

    invoke-static {v3, v4}, Ljava/lang/Float;->compare(FF)I

    move-result v3

    if-eqz v3, :cond_2

    return v2

    :cond_2
    iget v3, p0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->iqaScore:F

    iget v1, v1, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->iqaScore:F

    invoke-static {v3, v1}, Ljava/lang/Float;->compare(FF)I

    move-result v1

    if-eqz v1, :cond_3

    return v2

    :cond_3
    return v0
.end method

.method public final getFaceScore()F
    .locals 1

    .line 22
    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->faceScore:F

    return v0
.end method

.method public final getIqaScore()F
    .locals 1

    .line 23
    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->iqaScore:F

    return v0
.end method

.method public hashCode()I
    .locals 3

    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->faceScore:F

    invoke-static {v0}, Ljava/lang/Float;->hashCode(F)I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget v2, p0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->iqaScore:F

    invoke-static {v2}, Ljava/lang/Float;->hashCode(F)I

    move-result v2

    add-int/2addr v1, v2

    return v1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "FaceCollectInfo(faceScore="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->faceScore:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", iqaScore="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->iqaScore:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1

    const-string v0, "out"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->faceScore:F

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeFloat(F)V

    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;->iqaScore:F

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeFloat(F)V

    return-void
.end method
